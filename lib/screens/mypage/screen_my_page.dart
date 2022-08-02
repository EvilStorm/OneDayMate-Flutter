import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:odm/screens/components/member_avatar.dart';
import 'package:odm/screens/mypage/widgets/my_page_menu.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({Key? key}) : super(key: key);

  final UserInfoController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  '마이페이지',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Row(
                children: [
                  MemberAvatar(
                    imageUrl: _controller.userInfo.value.pictureMe,
                    size: 64,
                  ),
                  const SizedBox(
                    width: Constants.sapceGap * 4,
                  ),
                  Column(
                    children: [
                      Text(
                        _controller.userInfo.value.nickName ?? "known",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: Constants.sapceGap * 3,
              ),
              MyPageMenu(
                title: '공지사항',
                onClick: () {},
              ),
              MyPageMenu(
                title: '알림설정',
                onClick: () {},
              ),
              MyPageMenu(
                title: '개인정보 처리방침',
                onClick: () {},
              ),
              MyPageMenu(
                title: '로그아웃',
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
