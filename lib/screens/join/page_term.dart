import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/components/circle_checkbox.dart';
import 'package:odm/screens/components/outline_accent_button.dart';
import 'package:odm/screens/join/widgets/header.dart';

class PageTerm extends StatelessWidget {
  PageTerm({Key? key}) : super(key: key);
  final JoinController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(title: '약관동의가 필요해요', desc: '필수항목 및 선택항목 약관에 동의해주세요.'),
          ButtonLineAccent(
            text: '약관에 모두 동의',
            isAccent: true,
            action: _controller.termsAllAgree,
          ),
          const SizedBox(
            height: Constants.sapceGap * 8,
          ),
          Row(
            children: [
              CheckBoxCircle(
                  key: UniqueKey(),
                  isChecked: _controller.termUsed.value,
                  scale: 1.2,
                  action: (state) {
                    _controller.termUsed.value = state;
                  }),
              Expanded(
                child: GestureDetector(
                  onTap: _controller.showUsedTerm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '이용약관(필수)',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              CheckBoxCircle(
                  key: UniqueKey(),
                  isChecked: _controller.termUserInfo.value,
                  scale: 1.2,
                  action: (state) {
                    _controller.termUserInfo.value = state;
                  }),
              Expanded(
                child: GestureDetector(
                  onTap: _controller.showUsedInfoTerm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '개인정보 취급방침(필수)',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Button(
            text: "다음",
            action: () {
              if (_controller.validationTerms()) {
                _controller.moveNext();
              }
            },
            isAccent: true,
          ),
        ],
      ),
    );
  }
}
