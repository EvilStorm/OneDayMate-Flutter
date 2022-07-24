import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/screens/main/widgets/main_header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.black,
        onPressed: () {
          Get.toNamed('/mating/create');
        },
        child: SvgPicture.asset(
          'assets/images/icon_plus.svg',
          color: Colors.white,
          width: 26,
          height: 26,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.sapceGap * 5,
          vertical: Constants.sapceGap * 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MainHeader(),
            const SizedBox(
              height: Constants.sapceGap * 7,
            ),
            Text(
              '내 주변 스타일 모임 ✨',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: Constants.sapceGap * 4,
            ),
          ],
        ),
      ),
    );
  }
}
