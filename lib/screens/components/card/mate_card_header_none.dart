import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/controller_mating_actions.dart';
import 'package:odm/controllers/model_mate.dart';
import 'package:odm/screens/components/card/mate_card_state_label.dart';

class MateCardHeaderNone extends StatefulWidget {
  final MateModel mateInfo;

  MateCardHeaderNone({
    Key? key,
    required this.mateInfo,
  }) : super(key: key);

  @override
  State<MateCardHeaderNone> createState() => _MateCardHeaderNoneState();
}

class _MateCardHeaderNoneState extends State<MateCardHeaderNone> {
  final MatingActionController _controller = Get.find();

  bool isLike = false;

  @override
  void initState() {
    setState(() {
      isLike = widget.mateInfo.isLike ?? false;
    });
    super.initState();
  }

  bool passed() {
    if (widget.mateInfo.mateDate!.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  Row actions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            var result =
                await _controller.updateLikeState(widget.mateInfo.sId!);
            setState(() {
              isLike = result;
            });
          },
          child: isLike
              ? SvgPicture.asset(
                  'assets/images/icon_like_fill.svg',
                  width: 24,
                  height: 24,
                )
              : SvgPicture.asset(
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
    return Row(
      children: [
        MateCardStateLabel(isPassed: passed()),
        const Spacer(),
        actions(),
      ],
    );
  }
}
