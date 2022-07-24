import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/controller_sign.dart';
import 'package:odm/screens/components/button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final SignController _signController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Home2'),
              Button(
                text: '로그아웃',
                action: () {
                  _signController.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
