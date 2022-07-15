import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/controller_third_party_signin.dart';

import 'button_circle.dart';

class ThirdPartySignInSection extends StatelessWidget {
  ThirdPartySignInSection({Key? key, required this.height}) : super(key: key);

  final double height;
  final double appIconSize = 35;

  final ThirdPartySignInController controller = Get.find();
  bool notNull(Object? o) => o != null;

  dynamic _thirdPartyBtns() {
    return <Widget?>[
      CircleButton(
        callback: () {
          controller.signInWithGoogle();
        },
        child: SvgPicture.asset(
          "assets/images/google_logo.svg",
          width: appIconSize,
          height: appIconSize,
        ),
      ),
      CircleButton(
        callback: () {
          controller.signInWithFacebook();
        },
        backgroundColor: const Color(0xFF4267B2),
        child: SvgPicture.asset(
          "assets/images/facebook_logo.svg",
          width: appIconSize,
          height: appIconSize,
          color: Colors.white,
        ),
      ),
      CircleButton(
        callback: () {
          controller.signInWithKakao();
        },
        backgroundColor: const Color(0xFFFFE812),
        child: SvgPicture.asset(
          "assets/images/kakaotalk_logo.svg",
          width: appIconSize,
          height: appIconSize,
        ),
      ),
      Platform.isAndroid
          ? CircleButton(
              callback: () {
                controller.signInWithApple();
              },
              backgroundColor: const Color(0xFF555555),
              child: SvgPicture.asset(
                "assets/images/apple_logo.svg",
                width: appIconSize,
                height: appIconSize,
              ),
            )
          : null,
    ].where(notNull).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [..._thirdPartyBtns()],
      ),
    );
  }
}
