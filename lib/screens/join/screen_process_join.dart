import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/screens/join/page_gender.dart';
import 'package:odm/screens/join/page_location.dart';
import 'package:odm/screens/join/page_nick.dart';
import 'package:odm/screens/join/page_category.dart';
import 'package:odm/screens/join/page_term.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class JoinProcessScreen extends StatelessWidget {
  JoinProcessScreen({Key? key}) : super(key: key);

  final JoinController _controller = Get.find();

  final pageList = [
    PageTerm(),
    PageNickName(),
    PageLocationSelect(),
    PageGender(),
    PageTagCategory(),
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
                    lineHeight: 3,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
