import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_brief_addr.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/controllers/controller_sign.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/join/page_location.dart';
import 'package:odm/screens/join/page_term.dart';
import 'package:odm/utils/print.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class JoinProcessScreen extends StatelessWidget {
  JoinProcessScreen({Key? key}) : super(key: key);

  JoinController _controller = Get.find();

  var pageList = [
    PageLocationSelect(),
    PageTerm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.sapceGap * 3),
                    child: IconButton(
                      onPressed: _controller.movePrev,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.sapceGap * 2),
                  child: LinearPercentIndicator(
                    lineHeight: 6,
                    percent: (_controller.currentPageIndex.value + 1) /
                        pageList.length,
                    progressColor: ColorStore.primaryColor,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(Constants.sapceGap * 5),
                  child: pageList[_controller.currentPageIndex.value],
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.sapceGap * 5),
                  child: Button(
                    text: "다음",
                    action: _controller.moveNext,
                    isAccent: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
