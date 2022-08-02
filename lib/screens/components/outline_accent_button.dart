import 'package:flutter/material.dart';
import 'package:odm/constants/constants.dart';

class ButtonLineAccent extends StatelessWidget {
  final String text;
  final bool? isAccent;
  final Function? action;
  const ButtonLineAccent(
      {Key? key, required this.text, this.isAccent, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.sapceGap * 3)),
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
              color: (isAccent ?? false)
                  ? Theme.of(context).primaryColor
                  : Colors.black),
        ),
      ),
    );
  }
}
