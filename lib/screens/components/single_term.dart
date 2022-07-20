import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:odm/utils/device_util.dart';

class SingleTerm extends StatelessWidget {
  final String title;
  final String term;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          Text('이용약관',
              textAlign: TextAlign.end,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.headline6),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).dialogBackgroundColor),
              margin: const EdgeInsets.only(top: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Html(
                  data: term,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
