import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odm/constants/key_store.dart';
import 'package:odm/controllers/controller_sign.dart';
import 'package:odm/screens/components/dialog_basic.dart';
import 'package:odm/utils/print.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:odm/models/model_app_start.dart';
import 'package:odm/models/model_app_version.dart';

import '../network/http_client.dart';
import 'basic_controller_fn.dart';

class SplashController extends GetxController
    with StateMixin<AppStartModel>, BasicControllorFunctions {
  final _storage = GetStorage();

  SplashController() {
    getAppInitData();
    // _storage.write(KeyStore.appVer_I, 0);
  }

  late AppVersionModel _appVersionModel;

  void getAppInitData() async {
    final packageInfo = await PackageInfo.fromPlatform();

    var appVersion = _storage.read(KeyStore.appVer_I) ?? 0;
    if (int.parse(packageInfo.buildNumber) > appVersion) {
      appVersion = int.parse(packageInfo.buildNumber);
    }

    try {
      final response =
          await HttpClient.instance.get('/appVersion/after/$appVersion');

      if (response['code'] == 200) {
        _appVersionModel = AppVersionModel.fromJson(response['data'][0]);
        _hasNewAppVersion();
      } else if (response['code'] == 254) {
        moveNext();
      } else {
        Print.w("Respose COde: ${response['code']}");
      }
    } catch (e) {
      Print.e(e);
      responseException(e);
    }
  }

  void _launchStore() {}

  void _hasNewAppVersion() {
    if (_appVersionModel.isMustUpdate ?? false) {
      _showNessearyUpdatePop();
    } else {
      _showUpdatePop();
    }
  }

  void _showNessearyUpdatePop() {
    Get.dialog(
      BasicDialog(
        title: "필수 업데이트",
        message: _appVersionModel.say ?? "",
        leftBtnTitle: "종료",
        leftBtnAction: () => exit(0),
        rightBtnTitle: "업데이트",
        rightBtnAction: () => _launchStore(),
        rightBtnAccent: true,
      ),
      barrierDismissible: false,
    );
  }

  void _showUpdatePop() {
    Get.dialog(
      BasicDialog(
        message: _appVersionModel.say ?? "",
        leftBtnTitle: "건너뛰기",
        leftBtnAction: () {
          _storage.write(KeyStore.appVer_I, _appVersionModel.appVer);
          moveNext();
        },
        rightBtnTitle: "업데이트",
        rightBtnAccent: true,
        rightBtnAction: () => _launchStore(),
      ),
      barrierDismissible: false,
    );
  }

  void moveNext() {
    final SignController controller = Get.find();
    controller.signInContollerStart();
  }
}
