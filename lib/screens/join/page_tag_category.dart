import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';

import 'package:odm/controllers/controller_join.dart';
import 'package:odm/models/model_tag_category.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/join/widgets/header.dart';
import 'package:odm/screens/join/widgets/tag_category_item.dart';

class PageTagCategory extends StatelessWidget {
  PageTagCategory({Key? key}) : super(key: key);
  final JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(
              title: '스타일 태그를 선택해주세요',
              desc: '관심있는 태그를 바탕으로 나와 잘맞는\n모임을 추천해드릴께요!(최대 3개)'),
          Expanded(
            child: GridView.builder(
              itemCount: _joinController.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                TagCategoryModel item = _joinController.categoryList[index];
                final selected =
                    _joinController.selectedCategoryList.contains(index);
                return GestureDetector(
                  onTap: () => _joinController.setSelect(index),
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
            text: "가입하기",
            action: () {
              _joinController.done();
            },
            isAccent: true,
          ),
        ],
      ),
    );
  }
}
