import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/constroller_posting.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/mate_post/widgets/section_add_image.dart';
import 'package:odm/screens/mate_post/widgets/section_header.dart';
import 'package:odm/screens/mate_post/widgets/text_input.dart';

class TitlePage extends StatelessWidget {
  TitlePage({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SectionHeaderText(title: '스타일 이미지를 등록해주세요'),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        AddImageSection(),
        const SizedBox(
          height: Constants.sapceGap * 6,
        ),
        const SectionHeaderText(title: '모임 제목을 입력해주세요'),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        TextInputBox(
          hint: '제목을 입력해주세요',
          maxLength: 30,
          maxLine: 1,
          controller: _controller.titleTextController,
        ),
        const SizedBox(
          height: Constants.sapceGap * 6,
        ),
        const SectionHeaderText(title: '모임 소개글을 입력해주세요'),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        TextInputBox(
          hint: '소개글을 적어주세요.',
          maxLength: 600,
          maxLine: 10,
          controller: _controller.descTextController,
        ),
        const Spacer(),
        Button(
            isDisable: true,
            isAccent: true,
            action: () {
              if (_controller.isLastPage()) {
                _controller.postStyleMate();
              } else {
                _controller.next();
              }
            },
            text: _controller.isLastPage() ? '모임 만들기' : '다음'),
      ],
    );
  }
}
