import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_my_action.dart';
import 'package:odm/screens/myactions/created/screen_created_mate.dart';
import 'package:odm/screens/myactions/joined/screen_joined_date.dart';
import 'package:odm/screens/myactions/liked/screen_liked_mate.dart';

class MyActionsScreen extends StatelessWidget {
  MyActionsScreen({Key? key}) : super(key: key);

  final MyActionsController _controller = Get.find();
  final tabScreenWidgets = [
    CreatedMateScreen(),
    JoinedMateScreen(),
    LikedMateScreen(),
  ];

  Widget tabWidge(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        Constants.sapceGap / 2,
        0,
        Constants.sapceGap / 2,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.sapceGap * 6),
                child: Text(
                  '내 모임',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                controller: _controller.tabbarController,
                indicatorPadding: const EdgeInsets.only(
                    left: Constants.sapceGap, right: Constants.sapceGap),
                tabs: [
                  tabWidge(context, '만든 모임'),
                  tabWidge(context, '참여한 모임'),
                  tabWidge(context, '관심 모임'),
                ],
              ),
              const SizedBox(
                height: Constants.sapceGap * 6,
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller.tabbarController,
                  children: tabScreenWidgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
