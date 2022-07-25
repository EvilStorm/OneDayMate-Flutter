import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_posting.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/mate_post/posting_date_page.dart';
import 'package:odm/screens/mate_post/posting_tag_category_page.dart';
import 'package:odm/screens/mate_post/posting_tag_page.dart';
import 'package:odm/screens/mate_post/posting_title_page.dart';
import 'package:odm/screens/mate_post/widgets/posting_progress.dart';

class MatePostingScreen extends StatelessWidget {
  MatePostingScreen({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  List<Widget> pageList = [
    TitlePage(),
    PostingTagCategoryPage(),
    TagPage(),
    DatePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _controller.back();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text(
            '스타일 모임 만들기',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 5),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostingProgress(),
                  const SizedBox(
                    height: Constants.sapceGap * 6,
                  ),
                  Expanded(child: pageList[_controller.pageIndex.value]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
