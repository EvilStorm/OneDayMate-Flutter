import 'package:flutter/material.dart';

import 'package:odm/constants/color_store.dart';

class CheckBoxCircle extends StatefulWidget {
  final Function? action;
  final double? scale;
  final bool? isChecked;
  const CheckBoxCircle({
    Key? key,
    this.action,
    this.scale,
    this.isChecked,
  }) : super(key: key);

  @override
  State<CheckBoxCircle> createState() => _CheckBoxCircleState();
}

class _CheckBoxCircleState extends State<CheckBoxCircle> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale ?? 1,
      child: Checkbox(
        value: isChecked,
        shape: const CircleBorder(),
        fillColor:
            MaterialStateProperty.resolveWith(ColorStore.materiStateType1),
        onChanged: (bool? state) {
          setState(() {
            isChecked = state ?? false;
            widget.action?.call(isChecked);
          });

          // _controller.termUsed.value = state ?? false;
        },
      ),
    );
  }
}
