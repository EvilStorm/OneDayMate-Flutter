import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/controller_brief_addr.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/controllers/controller_sign.dart';
import 'package:odm/screens/join/page_location.dart';
import 'package:odm/utils/print.dart';

class JoinProcessScreen extends StatelessWidget {
  JoinProcessScreen({Key? key}) : super(key: key);
  final SignController _signController = Get.find();

  JoinController _controller = Get.find();

  var pageList = [
    PageLocationSelect(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pageList[_controller.currentPageIndex.value],
      ),
    );
  }
}
