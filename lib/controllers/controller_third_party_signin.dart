import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/utils/print.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ThirdPartySignInController extends GetxController
    with BasicControllorFunctions {
  final storage = GetStorage();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      showLoadingDialog();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Print.e(e);
      return null;
    } finally {
      hideLoadingDialog();
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      showLoadingDialog();

      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken?.token == null) {
        return null;
      }
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } catch (e) {
      Print.e(e);
      return null;
    } finally {
      hideLoadingDialog();
    }
  }

  Future<UserCredential?> signInWithKakao() async {
    try {
      showLoadingDialog();

      KakaoSdk.init(nativeAppKey: 'b1c8572d7c772bce02b913c7c1e9e08c');
      var hasKakaoTalk = await isKakaoTalkInstalled();
      late OAuthToken kakaoAuth;
      if (hasKakaoTalk) {
        kakaoAuth = await UserApi.instance.loginWithKakaoTalk();
      } else {
        kakaoAuth = await UserApi.instance.loginWithKakaoAccount();
      }

      var response = await http.post(
          Uri.parse("http://192.168.0.4:2394/api/auth/callbacks/kakao/token"),
          body: {"accessToken": kakaoAuth.accessToken});

      return await FirebaseAuth.instance.signInWithCustomToken(response.body);
    } catch (e) {
      Print.e(e);
      return null;
    } finally {
      hideLoadingDialog();
    }
  }

  void signInWithApple() async {
    try {
      showLoadingDialog();

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      Print.e(e);
      return null;
    } finally {
      hideLoadingDialog();
    }
  }
}
