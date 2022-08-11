import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_my_action.dart';
import 'package:odm/screens/components/card/mating_card.dart';
import 'package:odm/screens/myactions/empty.dart';

class LikedMateScreen extends StatelessWidget {
  LikedMateScreen({Key? key}) : super(key: key);
  final MyActionsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.likeMateList.isEmpty
          ? const EmptyView(
              title: '관심이 모임이 😳',
              message: '관심 있는 모임을\n스크랩 해둬요!',
            )
          : ListView.separated(
              itemCount: _controller.likeMateList.length,
              itemBuilder: (context, index) {
                return MatingCard(
                  key: UniqueKey(),
                  type: MatingCardType.like,
                  height: 160,
                  controller: _controller,
                  mateModel: _controller.likeMateList.elementAt(index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: Constants.sapceGap * 4,
              ),
            ),
    );
  }
}
