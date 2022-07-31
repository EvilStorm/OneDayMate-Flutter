import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_mating_detail.dart';
import 'package:odm/screens/mate_post/widgets/widget_tag.dart';

class MateAddedTags extends StatelessWidget {
  final MatingDetailController _detailController = Get.find();
  MateAddedTags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '태그',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: Constants.sapceGap * 2,
        ),
        Obx(
          () => Wrap(
            runSpacing: Constants.sapceGap * 2,
            children: [
              ...?_detailController.mateModel.value.tags?.map(
                (e) => GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: Constants.sapceGap * 3),
                    child: TagWidget(
                      borderColor: ColorStore.colorD6,
                      backgroundColor: ColorStore.colorF6,
                      tag: '#${e.tag}',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
