import 'dart:async';

import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/components/piece_brief_addr.dart';
import 'package:odm/controllers/components/piece_gender_age.dart';
import 'package:odm/controllers/components/piece_join_nick.dart';
import 'package:odm/controllers/components/piece_join_term.dart';
import 'package:odm/controllers/components/piece_category.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:get/get.dart';
import 'package:odm/models/model_user.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class JoinController extends GetxController
    with
        BasicControllorFunctions,
        JoinTermPiece,
        JoinNickPiece,
        BriefSearchAddressPiece,
        GenderAgePiece,
        CategoryPiece {
  var currentPageIndex = 0.obs;
  var totalPage = 5;

  final UserInfoController _userInfoController = Get.find();

  Timer? _nickNameReqTimer;
  Timer? _searchTmer;

  @override
  void onInit() {
    nickNameController.addListener(() {
      _nickNameReqTimer?.cancel();
      _nickNameReqTimer =
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
        checkNickName(nickNameController.text.trim());
        timer.cancel();
      });
    });

    searchController.addListener(() {
      _searchTmer?.cancel();
      _searchTmer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        if (searchController.text.isEmpty) {
          searchClear();
          return;
        }
        searchBriefAddress();
        timer.cancel();
      });
    });

    getCategory();

    super.onInit();
  }

  void calcStartIndex() {
    if (_userInfoController.userInfo.value.nickName == null) {
      currentPageIndex.value = 0;
    } else {
      currentPageIndex.value = 0;
    }
  }

  void moveNext() {
    if (currentPageIndex.value == totalPage) return;

    currentPageIndex.value = currentPageIndex.value + 1;
  }

  void movePrev() {
    if (currentPageIndex.value == 0) return;

    currentPageIndex.value = currentPageIndex.value - 1;
  }

  void done() async {
    try {
      showLoadingDialog();
      var temp = [];
      for (var selectedCategoryType in selectedCategoryList) {
        temp.add(categoryList.elementAt(selectedCategoryType).sId);
      }
      var response = await HttpClient.instance.patch(
        '/user',
        body: {
          'nickName': nickNameController.text.trim(),
          'location': selectedLocation.value.trim(),
          'age': age.value.round(),
          'gender': gender.value == Gender.male,
          'category': temp,
        },
      );

      if (response['code'] == 200) {
        var user = UserModel.fromJson(response['data']);
        UserInfoController userInfo = Get.find<UserInfoController>();
        userInfo.setUserInfo(user, false);
      } else {
        showMessage(response['data']['message']);
      }
    } catch (e) {
      Print.e(e);
    } finally {
      hideLoadingDialog();
    }
  }

  Future<bool> setUserInfo(dynamic info) async {
    var response = await HttpClient.instance.patch(
      '/user',
      body: info,
    );

    if (response['code'] == 200) {
      return true;
    } else {
      showMessage(response['data']['message']);
      return false;
    }
  }

  bool validationNick() {
    if (nickNameController.text == '' || nickNameController.text.length < 2) {
      showMessage('2자 이상의 닉네임을 입력해주세요');
      return false;
    }
    if (checkedNickName.value == false) {
      showMessage('닉네임을 변경해주세요');
      return false;
    }
    return true;
  }

  bool validationTerms() {
    if (termUsed.value == false || termUserInfo.value == false) {
      showMessage('약관을 읽고 체크해주세요.');
      return false;
    }
    return true;
  }

  bool validationLocation() {
    if (selectedLocation.isEmpty) {
      showMessage('활동지역을 등록해주세요.');
      return false;
    }
    return true;
  }
}
