import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odm/constants/constants.dart';

class DetailLikeButton extends StatelessWidget {
  final bool isLike;
  final double iconSize;
  final VoidCallback click;
  const DetailLikeButton(
      {Key? key,
      required this.isLike,
      required this.click,
      required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.sapceGap * 3)),
        side: const BorderSide(
          width: 2,
          color: Color(0xFFD6D6D6),
        ),
      ),
      onPressed: click,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap * 4),
        child: isLike
            ? SvgPicture.asset(
                'assets/images/icon_like_fill.svg',
                width: iconSize,
                height: iconSize,
              )
            : SvgPicture.asset(
                'assets/images/icon_like.svg',
                color: Colors.red,
                width: iconSize,
                height: iconSize,
              ),
      ),
    );
  }
}
