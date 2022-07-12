import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/controller_splash.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: controller.obx((state) {
          return loadingWidget(context);
        }, onLoading: loadingWidget(context)),
      ),
    );
  }

  Container loadingWidget(BuildContext context) {
    return Container(
      height: Get.size.height,
      width: Get.size.width,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: SvgPicture.asset('assets/images/stylemate_splash_logo.svg'),
      ),
    );
  }
}
