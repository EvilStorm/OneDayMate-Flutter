import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/models/model_user.dart';
import 'package:odm/network/http_client.dart';

class UserInfoController extends GetxController with BasicControllorFunctions {
  Rx<UserModel> userInfo = UserModel().obs;

  void setUserInfo(UserModel data, bool isSilent) async {
    userInfo.value = data;

    await sendFcmToken(data.pushToken);

    if (isSilent) {
      return;
    }
    if (data.nickName == null || data.age == null || data.gender == null) {
      Get.toNamed('/joinProcess');
    } else {
      Get.offAllNamed('/home');
    }
  }

  Future<void> sendFcmToken(String? token) async {
    var currentToken = await FirebaseMessaging.instance.getToken();

    if (token == currentToken) return;
    await patchUserInfo({'pushToken': currentToken});
    return;
  }

  Future<bool> patchUserInfo(dynamic info) async {
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
