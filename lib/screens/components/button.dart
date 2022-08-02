import 'package:flutter/material.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final bool? isAccent;
  final bool? isDisable;
  final Function? action;
  const Button(
      {Key? key,
      required this.text,
      this.isAccent,
      this.action,
      this.isDisable})
      : super(key: key);

  Color getBackgroundColor() {
    if (isDisable ?? false) {
      return ColorStore.colorF0;
    }

    if (isAccent ?? false) {
      return ColorStore.primaryColor;
    }
    return Colors.white;
  }

  Color getBorderColor() {
    if (isDisable ?? false) {
      return ColorStore.colorF0;
    }

    if (isAccent ?? false) {
      return ColorStore.primaryColor;
    }
    return const Color(0xFFD6D6D6);
  }

  Color getTextColor() {
    if (isDisable ?? false) {
      return ColorStore.colorAF;
    }

    if (isAccent ?? false) {
      return Colors.white;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.sapceGap * 3)),
        backgroundColor: getBackgroundColor(),
        side: BorderSide(
          width: 2,
          color: getBorderColor(),
        ),
      ),
      onPressed: () {
        if (isDisable ?? false) {
          return;
        }
        action?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap * 5),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: getTextColor()),
        ),
      ),
    );
  }
}
