import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:odm/constants/key_store.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/components/piece_posting_title.dart';
import 'package:odm/controllers/components/piece_poting_image.dart';
import 'package:odm/controllers/components/piece_category.dart';
import 'package:odm/controllers/controller_main.dart';
import 'package:odm/controllers/model_mate.dart';
import 'package:odm/models/model_brief_addr.dart';
import 'package:odm/models/model_tag.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/screens/mate_post/widgets/added_picture.dart';
import 'package:odm/screens/sign/widget_add_account_email.dart';
import 'package:odm/utils/print.dart';

class PostingController extends GetxController
    with
        BasicControllorFunctions,
        PostionImagePiece,
        PostingTitlePiece,
        CategoryPiece {
  var pageIndex = 0.obs;
  var maxPageIndex = 4;

  RxList<String> addedTags = <String>[].obs;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController localeController = TextEditingController();

  final RxList<TagModel> hotTagList = <TagModel>[].obs;
  final RxList<TagModel> searchTagList = <TagModel>[].obs;
  final RxList<BriefAddressModel> searchLocaleList = <BriefAddressModel>[].obs;

  final RxBool tagIsNotFound = false.obs;
  final RxBool showTagSearchResult = false.obs;
  final RxBool tagSearchDone = false.obs;

  var selectedDate = DateTime.now().obs;
  var dateSelected = false.obs;
  var localeSelected = BriefAddressModel().obs;

  var selectedTime = DateTime.now().obs;
  var timeSelected = false.obs;

  var searchWord = "".obs;

  Timer? _searchTmer;

  var memberCount = 2.obs;
  var maxMemberCount = 108;

  var ageDontCare = true.obs;
  var ageRange = RangeValues(20, 35).obs;

  var titlePageValidation = false.obs;

  var canPosting = false.obs;

  void clearSearch() {
    searchController.text = "";
    tagIsNotFound.value = false;
    showTagSearchResult.value = false;
    tagSearchDone.value = false;
    searchTagList.clear();
    searchWord.value = "";
  }

  @override
  void onInit() {
    getCategory();
    setSelectedMaxCount(1);

    titleTextController.addListener(() {
      titleValidation();
    });
    descTextController.addListener(() {
      titleValidation();
    });

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        return;
      }
      showTagSearchResult.value = true;
      searchWord.value = searchController.text;
      _searchTmer?.cancel();

      _searchTmer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        Print.e(' DO SEARCH Word: ${searchController.text}');
        searchTag();
        timer.cancel();
      });
    });

    localeController.addListener(() {
      if (localeController.text.isEmpty) {
        return;
      }

      _searchTmer?.cancel();

      _searchTmer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        searchLocale();
        timer.cancel();
      });
    });

    super.onInit();
  }

  void setMateDate(DateTime date) {
    selectedDate.value = date;
    dateSelected.value = true;
  }

  void setMateTime(DateTime date) {
    selectedTime.value = date;
    timeSelected.value = true;
  }

  bool isMemberMax() {
    if (memberCount.value >= maxMemberCount) {
      return true;
    }
    return false;
  }

  void addMember() {
    if (isMemberMax()) {
      return;
    }
    memberCount.value = memberCount.value + 1;
  }

  void removeMember() {
    if (memberCount.value == 2) {
      return;
    }
    memberCount.value = memberCount.value - 1;
  }

  void getTagList() async {
    if (hotTagList.isNotEmpty) {
      return;
    }
    final response = await HttpClient.instance.get('/tag/hot');

    if (response['code'] == 200) {
      hotTagList.value = (response['data'] as List)
          .map((item) => TagModel.fromJson(item))
          .toList();
    }
  }

  void searchTag() async {
    tagIsNotFound.value = false;
    showTagSearchResult.value = true;

    if (searchController.text.trim().isEmpty) {
      return;
    }
    tagSearchDone.value = false;
    searchTagList.clear();
    final response = await HttpClient.instance
        .get('/tag/search/${searchController.text.trim()}');

    if (response['code'] == 200) {
      searchTagList.value = (response['data'] as List)
          .map((item) => TagModel.fromJson(item))
          .toList();
    } else {
      tagIsNotFound.value = true;
    }
    tagSearchDone.value = true;
  }

  void clearSearchLocale() {
    localeController.text = "";
    searchLocaleList.clear();
  }

  void searchLocale() async {
    if (localeController.text.trim().isEmpty) {
      return;
    }

    searchLocaleList.clear();
    final response = await HttpClient.instance
        .get('/briefAddr/search/${localeController.text.trim()}');

    if (response['code'] == 200) {
      searchLocaleList.value = (response['data'] as List)
          .map((item) => BriefAddressModel.fromJson(item))
          .toList();
    }
  }

  void addTag(String tag) {
    clearSearch();
    if (addedTags.contains(tag)) {
      return;
    }
    addedTags.add(tag);
  }

  void removeTag(String tag) {
    addedTags.remove(tag);
  }

  bool back() {
    if (pageIndex.value == 0) {
      return true;
    } else {
      prev();
      return false;
    }
  }

  bool isLastPage() {
    if (pageIndex.value + 1 == maxPageIndex) {
      return true;
    }
    return false;
  }

  void next() {
    if (isLastPage()) {
      return;
    }
    pageIndex.value = pageIndex.value + 1;
  }

  void prev() {
    if (pageIndex.value == 0) {
      return;
    }
    pageIndex.value = pageIndex.value - 1;
  }

  void postStyleMate() async {
    if (!postingValidation()) {
      return;
    }
    showLoadingDialog();
    await postingImages();

    try {
      var response = await HttpClient.instance.post(
        '/mate',
        body: {
          'images': imageUrl,
          'title': titleTextController.text.trim(),
          'message': descTextController.text.trim(),
          'locationStr': localeSelected.value.dong,
          'mateDate': selectedDate.value.toString(),
          'category': categoryList[selectedCategoryList[0]].sId,
          'memberLimit': memberCount.value,
          'tags': addedTags,
          'maxAge': ageDontCare.value ? 0 : ageRange.value.end.round(),
          'minAge': ageDontCare.value ? 0 : ageRange.value.start.round(),
        },
      );

      if (response['code'] == 200) {
        var mate = MateModel.fromJson(response['data']);
        // MainController _controller = Get.find();
        // _controller.addMainMate(mate);

        Get.back();
      } else {
        showRetryMessage();
      }
    } catch (e) {
      Print.e(e);
      showRetryMessage();
    } finally {
      hideLoadingDialog();
    }
  }

  bool postingValidation() {
    if (titleTextController.text.isEmpty) {
      showMessage('제목을 입력해주세요.');
      pageIndex.value = 0;
      return false;
    }

    if (descTextController.text.isEmpty) {
      showMessage('소개글을 적어주세요');
      pageIndex.value = 0;
      return false;
    }

    if (addedTags.isEmpty) {
      showMessage('최소 하나의 테그는 필요합니다.');
      pageIndex.value = 1;
      return false;
    }
    if (!dateSelected.value) {
      showMessage('날자를 입력해주새요.');
      return false;
    }

    if (!timeSelected.value) {
      showMessage('시간을 입력해주새요.');
      return false;
    }

    if (localeSelected.value.fullAddress == null) {
      showMessage('장소를 입력해주새요.');
      return false;
    }

    // selectedDate.value.subtract(Duration(
    //     hours: selectedTime.value.hour, minutes: selectedTime.value.minute));
    canPosting(true);
    return true;
  }
}
