import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/components/piece_gender_age.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/components/slider_shape.dart';
import 'package:odm/screens/join/widgets/header.dart';

class PageGender extends StatelessWidget {
  PageGender({Key? key}) : super(key: key);

  final JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(
              title: '성별과 나이를 알려주세요', desc: '알려주신 정보를 기반으로\n스타일 모임을 찾을 수 있어요'),
          const SizedBox(
            height: Constants.sapceGap * 4,
          ),
          Text(
            '성별',
            style: Theme.of(context).textTheme.headline5,
          ),
          Row(
            children: [
              Radio(
                  value: Gender.MALE,
                  visualDensity: VisualDensity.compact,
                  fillColor: MaterialStateProperty.resolveWith(
                      ColorStore.materiStateType1),
                  groupValue: _joinController.gender.value,
                  onChanged: (value) {
                    _joinController.gender.value = value as Gender;
                  }),
              GestureDetector(
                onTap: () {
                  _joinController.gender.value = Gender.MALE;
                },
                child: Text(
                  '남자',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(
                width: Constants.sapceGap * 5,
              ),
              Radio(
                  value: Gender.FEMALE,
                  fillColor: MaterialStateProperty.resolveWith(
                      ColorStore.materiStateType1),
                  groupValue: _joinController.gender.value,
                  onChanged: (value) {
                    _joinController.gender.value = value as Gender;
                  }),
              GestureDetector(
                onTap: () {
                  _joinController.gender.value = Gender.FEMALE;
                },
                child: Text(
                  '여자',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Constants.sapceGap * 7,
          ),
          Text(
            '나이',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: Constants.sapceGap * 4,
          ),
          Text(
            '${_joinController.age.value.round()}세',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: ColorStore.primaryColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Slider(
              value: _joinController.age.value,
              min: 1,
              max: 100,
              onChanged: (_) {
                _joinController.age.value = _;
              },
            ),
          ),
          const Spacer(),
          Button(
            text: "다음",
            action: () {
              _joinController.moveNext();
            },
            isAccent: true,
          ),
        ],
      ),
    );
  }
}
