import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_posting.dart';
import 'package:odm/screens/components/search_bar.dart';
import 'package:odm/screens/mate_post/widgets/section_header.dart';

class PageSelectLocation extends StatelessWidget {
  PageSelectLocation({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
                height: 740,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.sapceGap * 4,
                      vertical: Constants.sapceGap * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: Constants.sapceGap * 3,
                      ),
                      SectionHeaderText(title: '장소찾기'),
                      const SizedBox(
                        height: Constants.sapceGap * 3,
                      ),
                      SearchBar(
                        hint: '모임 장소를 입력해주세요',
                        controller: _controller.localeController,
                      ),
                      const SizedBox(
                        height: Constants.sapceGap * 4,
                      ),
                      Obx(
                        () => Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                _controller.localeSelected.value =
                                    _controller.searchLocaleList.elementAt(index);
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Constants.sapceGap * 2),
                                child: Text(
                                  _controller.searchLocaleList
                                          .elementAt(index)
                                          .fullAddress ??
                                      "",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => const Divider(
                              color: ColorStore.color89,
                            ),
                            itemCount: _controller.searchLocaleList.length,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: Constants.sapceGap * 2,
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}