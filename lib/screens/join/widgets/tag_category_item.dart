import 'package:flutter/material.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';

class TagCategoryItem extends StatelessWidget {
  final String title;
  final int type;
  final bool isSelected;
  TagCategoryItem({
    Key? key,
    required this.title,
    required this.type,
    required this.isSelected,
  }) : super(key: key);

  final categoryImags = [
    'assets/images/activity.png',
    'assets/images/study.png',
    'assets/images/value.png',
    'assets/images/food.png',
    'assets/images/culture.png',
    'assets/images/music.png',
    'assets/images/photo.png',
    'assets/images/fashion.png',
    'assets/images/creator.png',
    'assets/images/traval.png',
    'assets/images/book.png',
    'assets/images/hobby.png',
    'assets/images/animal.png',
    'assets/images/freemate.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color:
                isSelected ? ColorStore.primaryColor : ColorStore.unSelected),
        borderRadius: BorderRadius.circular(Constants.sapceGap * 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap * 5),
        child: Column(
          children: [
            Image(
              image: AssetImage(categoryImags[type - 1]),
            ),
            const SizedBox(
              height: Constants.sapceGap * 3,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.caption!.apply(
                    color: isSelected
                        ? ColorStore.primaryColor
                        : ColorStore.unSelected,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
