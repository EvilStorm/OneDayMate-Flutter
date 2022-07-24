import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/join/widgets/header.dart';

class PageNickName extends StatelessWidget {
  PageNickName({Key? key}) : super(key: key);
  final JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(
              title: '닉네임을 정해주세요', desc: '자신을 잘 보여줄 수 있는\n닉테임을 설정해주세요'),
          TextField(
            controller: _joinController.nickNameController,
            autocorrect: false,
            maxLength: 14,
            decoration: InputDecoration(
              counterText: '',
              hintText: '최소 2자 최대 14자 입력',
              suffixIcon: Visibility(
                visible: _joinController.nickNameController.text.isNotEmpty,
                child: GestureDetector(
                  onTap: () => _joinController.clearNickNameState(),
                  child: const Icon(
                    Icons.cancel,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 2,
          ),
          Text(
            _joinController.nickNameCheckState.value,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 12,
                  color: _joinController.checkedNickName.value
                      ? ColorStore.successColor
                      : ColorStore.errorColor,
                ),
          ),
          const Spacer(),
          Button(
            text: "다음",
            action: () {
              if (_joinController.validationNick()) {
                _joinController.moveNext();
              }
            },
            isAccent: true,
          ),
        ],
      ),
    );
  }
}
