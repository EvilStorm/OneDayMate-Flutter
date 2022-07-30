import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odm/controllers/model_mate.dart';
import 'package:odm/screens/components/card/mate_card_state_label.dart';

class MateCardHeaderNone extends StatelessWidget {
  final MateModel mateInfo;
  final Function? likeClick;

  MateCardHeaderNone({
    Key? key,
    required this.mateInfo,
    this.likeClick,
  }) : super(key: key);

  bool isPassedMate = false;

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
            likeClick?.call();
          },
          child: SvgPicture.asset(
            'assets/images/icon_like.svg',
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isPassedMate = passed();

    return Row(
      children: [
        MateCardStateLabel(isPassed: passed()),
        const Spacer(),
        actions(),
      ],
    );
  }
}
