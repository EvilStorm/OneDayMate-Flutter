import 'package:flutter/material.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:get/get.dart';
import 'package:odm/models/model_simple.dart';
import 'package:odm/network/http_client.dart';

class JoinController extends GetxController with BasicControllorFunctions {
  var pageIndex = 0.obs;
  var totalPage = 5;
  UserInfoController _userInfoController = Get.find();

  TextEditingController nickNameController = TextEditingController();

  void calcStartIndex() {
    if (_userInfoController.userInfo.value.nickName == null) {
      pageIndex.value = 0;
    } else if (_userInfoController.userInfo.value.gender == null) {
      pageIndex.value = 1;
    } else {
      pageIndex.value = 0;
    }
  }

  void moveNext() {
    if (pageIndex.value == totalPage) return;

    pageIndex.value = pageIndex.value + 1;
  }

  void movePrev() {
    if (pageIndex.value == 0) return;

    pageIndex.value = pageIndex.value - 1;
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
