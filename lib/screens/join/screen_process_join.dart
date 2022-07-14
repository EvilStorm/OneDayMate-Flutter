import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:odm/controllers/controller_sign.dart';
import 'package:odm/screens/components/button.dart';

class JoinProcessScreen extends StatelessWidget {
  JoinProcessScreen({Key? key}) : super(key: key);

  final SignController _signController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Button(
            text: 'Join LogOut',
            action: () => _signController.signOut(),
          ),
        ),
      ),
    );
  }
}
