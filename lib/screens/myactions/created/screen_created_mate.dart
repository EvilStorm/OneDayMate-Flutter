import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_my_action.dart';
import 'package:odm/screens/components/card/mating_card.dart';
import 'package:odm/screens/myactions/empty.dart';
import 'package:odm/utils/print.dart';

class CreatedMateScreen extends StatelessWidget {
  CreatedMateScreen({Key? key}) : super(key: key);

  final MyActionsController _controller = Get.find();
  void createMate() {
    Print.e(' Create Mate');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.createdMateList.isEmpty
          ? EmptyView(
              title: '내가 만든 모임이 없어요 😳',
              message: '나와 같이 할 사람을 모을\n모임을 만들러 갈까요?',
              btnText: '모임 만들기',
              onClick: createMate,
            )
          : ListView.separated(
              itemCount: _controller.createdMateList.length,
              itemBuilder: (context, index) {
                return MatingCard(
                  key: UniqueKey(),
                  type: MatingCardType.mine,
                  height: 160,
                  controller: _controller,
                  mateModel: _controller.createdMateList.elementAt(index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: Constants.sapceGap * 4,
              ),
            ),
    );
  }
}
