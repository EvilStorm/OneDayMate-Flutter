import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:odm/constants/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final bool? isAccent;
  final Function? action;
  const Button({Key? key, required this.text, this.isAccent, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.sapceGap * 3)),
        backgroundColor:
            (isAccent ?? false) ? Theme.of(context).primaryColor : Colors.white,
        side: BorderSide(
          width: 2,
          color: (isAccent ?? false)
              ? Theme.of(context).primaryColor
              : const Color(0xFFD6D6D6),
        ),
      ),
      onPressed: () => action?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap * 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
              color: (isAccent ?? false) ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
