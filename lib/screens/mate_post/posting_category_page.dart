import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_posting.dart';
import 'package:odm/models/model_category.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/join/widgets/tag_category_item.dart';
import 'package:odm/screens/mate_post/widgets/section_header.dart';

class PostingTagCategoryPage extends StatelessWidget {
  PostingTagCategoryPage({Key? key}) : super(key: key);
  final PostingController _postingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SectionHeaderText(title: '카테고리 설정'),
          const SizedBox(
            height: Constants.sapceGap * 2,
          ),
          Text(
            '모임의 주제와 맞는 카테고리를 설정해주세요.',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: Constants.sapceGap * 5,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _postingController.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                CategoryModel item = _postingController.categoryList[index];
                final selected =
                    _postingController.selectedCategoryList.contains(index);
                return GestureDetector(
                  onTap: () => _postingController.setSingleSelect(index),
                  child: TagCategoryItem(
                      key: UniqueKey(),
                      title: item.category ?? "",
                      type: item.type ?? 0,
                      isSelected: selected),
                );
              },
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 3,
          ),
          Button(
            isDisable: _postingController.selectedCategoryList.isEmpty,
            text: "다음",
            action: () {
              if (_postingController.selectedCategoryList.isNotEmpty) {
                _postingController.next();
              }
            },
            isAccent: true,
          ),
        ],
      ),
    );
  }
}
