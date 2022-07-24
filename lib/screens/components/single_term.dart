import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/screens/components/outline_accent_button.dart';

class SingleTerm extends StatelessWidget {
  final String title;
  final String? term;
  final VoidCallback callback;
  const SingleTerm({
    Key? key,
    required this.title,
    required this.term,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: const Color(0xFFF0F0F0),
      child: Padding(
        padding: const EdgeInsets.all(Constants.sapceGap * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            Text(title,
                textAlign: TextAlign.end,
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(
              height: Constants.sapceGap * 1,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F0F0),
                ),
                margin: const EdgeInsets.only(top: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Html(
                    data: term,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: Constants.sapceGap * 3,
            ),
            ButtonLineAccent(
              text: '확인',
              action: () {
                callback();
                Get.back();
              },
              isAccent: true,
            )
          ],
        ),
      ),
    );
  }
}
