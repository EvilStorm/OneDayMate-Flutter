import 'package:flutter/material.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:get/get.dart';
import 'package:odm/models/model_simple.dart';
import 'package:odm/network/http_client.dart';

class JoinController extends GetxController with BasicControllorFunctions {
  var currentPageIndex = 0.obs;
  var totalPage = 5;
  UserInfoController _userInfoController = Get.find();

  TextEditingController nickNameController = TextEditingController();

  void calcStartIndex() {
    if (_userInfoController.userInfo.value.nickName == null) {
      currentPageIndex.value = 0;
    } else if (_userInfoController.userInfo.value.gender == null) {
      currentPageIndex.value = 1;
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

  Future<bool> canUseNickName(String nickName) async {
    var response = await HttpClient.instance.get(
      '/user/check/nickName/$nickName',
    );

    if (response['code'] == 200) {
      var respModel = SimpleModel.fromJson(response['data']);
      if (respModel.result == 1) {
        return true;
      } else {
        showMessage(response['data']['message']);
        return false;
      }
    } else {
      showMessage(response['data']['message']);
      return false;
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
}
