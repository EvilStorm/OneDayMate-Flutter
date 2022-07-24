import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:odm/constants/constants.dart';

class Header extends StatelessWidget {
  final String title;
  final String desc;
  const Header({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        Text(
          desc,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(
          height: Constants.sapceGap * 6,
        ),
      ],
    );
  }
}
