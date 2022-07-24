import 'dart:async';

import 'package:get/get.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/components/piece_brief_addr.dart';

class BirefAddressSearchController extends GetxController
    with BasicControllorFunctions, BriefSearchAddressPiece {
  var selectedLocation = "".obs;

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

  bool validationLocation() {
    if (selectedLocation.isEmpty) {
      showMessage('활동지역을 등록해주세요.');
      return false;
    }
    return true;
  }
}
