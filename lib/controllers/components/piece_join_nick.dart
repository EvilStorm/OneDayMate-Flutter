import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:odm/models/model_simple.dart';
import 'package:odm/network/http_client.dart';

class JoinNickPiece {
  var nickName = "".obs;
  var nickNameCheckState = "".obs;
  var checkedNickName = false.obs;

  final TextEditingController nickNameController = TextEditingController();

  void clearNickNameState() {
    nickNameController.text = '';
    setNickNameState('', false, '');
  }

  void setNickNameState(String str, bool state, String stateStr) {
    nickName.value = str;
    checkedNickName.value = state;
    nickNameCheckState.value = stateStr;
  }

  Future<bool> checkNickName(String candidate) async {
    if (candidate.length < 2) {
      setNickNameState('', false, '');
      return false;
    }

    setNickNameState(candidate, true, "'$candidate' 확인 중 입니다. ");

    var response = await HttpClient.instance.get(
      '/user/check/nickName/$candidate',
    );

    if (response['code'] == 200) {
      var respModel = SimpleModel.fromJson(response['data']);
      if (respModel.result == 1) {
        setNickNameState(candidate, true, "사용 가능한 닉네임이에요.");
        return true;
      } else {
        setNickNameState('', false, response['data']['message']);
        return false;
      }
    } else {
      setNickNameState('', false, '');
      return false;
    }
  }
}
