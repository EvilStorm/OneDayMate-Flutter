import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_my_action.dart';
import 'package:odm/screens/components/card/mating_card.dart';
import 'package:odm/screens/myactions/empty.dart';

class JoinedMateScreen extends StatelessWidget {
  JoinedMateScreen({Key? key}) : super(key: key);

  final MyActionsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.joinedMateList.isEmpty
          ? const EmptyView(
              title: '아직 참여한 모임이 없어요 😳',
              message: '관심있는 모임에\n참여해보세요!',
            )
          : ListView.separated(
              itemCount: _controller.joinedMateList.length,
              itemBuilder: (context, index) {
                return MatingCard(
                  key: UniqueKey(),
                  type: MatingCardType.join,
                  height: 160,
                  controller: _controller,
                  mateModel: _controller.joinedMateList.elementAt(index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: Constants.sapceGap * 4,
              ),
            ),
    );
  }
}
