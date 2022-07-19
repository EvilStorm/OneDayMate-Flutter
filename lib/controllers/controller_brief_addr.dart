import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/models/model_brief_addr.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class BirefAddressSearchController extends GetxController
    with BasicControllorFunctions {
  final TextEditingController searchController = TextEditingController();
  final RxList<BriefAddressModel> searchAddressList = <BriefAddressModel>[].obs;
  var doSearch = false.obs;

  Timer? _searchTmer;

  @override
  void onInit() {
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

    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void searchBriefAddress() async {
    if (searchController.text.trim().isEmpty) {
      return;
    }
    searchAddressList.clear();
    doSearch(true);
    try {
      final response = await HttpClient.instance
          .get('/briefAddr/search/${searchController.text.trim()}');

      if (response['code'] == 200) {
        searchAddressList.value = (response['data'] as List)
            .map((item) => BriefAddressModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      Print.e(e);
    } finally {
      doSearch(false);
    }
  }

  void searchClear() {
    searchController.text = "";
    searchAddressList.clear();
  }
}
