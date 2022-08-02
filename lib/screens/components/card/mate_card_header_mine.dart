import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/models/model_mate.dart';
import 'package:odm/screens/components/card/mate_card_state_label.dart';

class MateCardHeaderMine extends StatelessWidget {
  final MateModel mateInfo;

  final Function? menuClick;
  final Function? replyClick;

  const MateCardHeaderMine({
    Key? key,
    required this.mateInfo,
    this.menuClick,
    this.replyClick,
  }) : super(key: key);

  bool passed() {
    if (mateInfo.mateDate!.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  Row actions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            replyClick?.call();
          },
          child: SvgPicture.asset('assets/images/icon_message.svg'),
        ),
        const SizedBox(
          width: Constants.sapceGap * 2.5,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            menuClick?.call();
          },
          icon: const Icon(
            Icons.more_vert,
            color: ColorStore.color43,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MateCardStateLabel(isPassed: passed()),
        const Spacer(),
        actions(),
      ],
    );
  }
}
