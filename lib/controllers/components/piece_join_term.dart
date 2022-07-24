import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:odm/models/model_term.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/screens/components/single_term.dart';

class JoinTermPiece {
  var termUsed = false.obs;
  var termUserInfo = false.obs;

  TermModel? _termModel;

  void showUsedTerm() async {
    _termModel = await getTerms();

    Get.dialog(
      SingleTerm(title: '이용약관', term: _termModel?.term, callback: () {}),
      barrierColor: Colors.transparent,
      useSafeArea: true,
    );
  }

  void showUsedInfoTerm() async {
    _termModel = await getTerms();
    Get.dialog(
      SingleTerm(
          title: '개인정보 취급방침', term: _termModel?.userTerm, callback: () {}),
      barrierColor: Colors.transparent,
      useSafeArea: true,
    );
  }

  Future<TermModel?> getTerms() async {
    if (_termModel != null) {
      return _termModel;
    }

    var response = await HttpClient.instance.get(
      '/term/last',
    );

    if (response['code'] == 200) {
      _termModel = TermModel.fromJson(response['data']);
    } else {
      Fluttertoast.showToast(msg: response['data']['message']);
      return null;
    }
    return _termModel;
  }

  void termsAllAgree() {
    termUsed(true);
    termUserInfo(true);
  }
}
