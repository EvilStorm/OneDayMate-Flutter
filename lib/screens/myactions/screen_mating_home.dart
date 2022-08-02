import 'package:flutter/material.dart';
import 'package:odm/constants/constants.dart';

class MyActionsScreen extends StatelessWidget {
  const MyActionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('MY Actions'),
            ],
          ),
        ),
      ),
    );
  }
}
