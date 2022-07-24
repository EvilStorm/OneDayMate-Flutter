import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/models/model_brief_addr.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class BriefSearchAddressPiece {
  final TextEditingController searchController = TextEditingController();
  final RxList<BriefAddressModel> searchAddressList = <BriefAddressModel>[].obs;
  var doSearch = false.obs;
  var selectedLocation = "".obs;

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
