import 'package:flutter/material.dart';
import 'package:odm/constants/constants.dart';

class BasicDialog extends StatelessWidget {
  final String message;
  final String? title;
  final String? leftBtnTitle;
  final Function? leftBtnAction;
  final String? rightBtnTitle;
  final Function? rightBtnAction;
  final double? height;
  final bool rightBtnAccent;
  final bool leftBtnAccent;

  const BasicDialog({
    Key? key,
    required this.message,
    this.title,
    this.leftBtnTitle,
    this.leftBtnAction,
    this.rightBtnTitle,
    this.rightBtnAction,
    this.height,
    this.rightBtnAccent = false,
    this.leftBtnAccent = false,
  }) : super(key: key);

  double getDefaultHeight() {
    return title != null ? 210 : 180;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: height ?? getDefaultHeight(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                  visible: title != null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(
                child: Center(
                  child: Text(
                    message.replaceAll("\\n", "\n"),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        height: 1.4,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              buttonSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buttonSection(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: leftBtnTitle != null,
          child: _button(context, leftBtnAccent, leftBtnTitle, leftBtnAction),
        ),
        Visibility(
            visible: leftBtnTitle != null,
            child: const SizedBox(
              width: 16.0,
            )),
        Visibility(
          visible: rightBtnTitle != null,
          child:
              _button(context, rightBtnAccent, rightBtnTitle, rightBtnAction),
        ),
      ],
    );
  }
}

Expanded _button(
    BuildContext context, bool isAccent, String? text, Function? action) {
  return Expanded(
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isAccent ? Theme.of(context).primaryColor : Colors.white,
        side: BorderSide(
          width: 2,
          color: isAccent
              ? Theme.of(context).primaryColor
              : const Color(0xFFD6D6D6),
        ),
      ),
      onPressed: () => action?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap),
        child: Text(
          text ?? "",
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: isAccent ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}
