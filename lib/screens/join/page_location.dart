import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/controller_join.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/join/widgets/header.dart';

class PageLocationSelect extends StatelessWidget {
  PageLocationSelect({Key? key}) : super(key: key);
  final JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(
              title: '어디에 살고있나요?', desc: '설정한 주소를 기반으로\n내 근처 모임을 알려드릴께요.'),
          TextField(
            controller: _joinController.searchController,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: '동(읍,면)으로 검색 (ex. 삼성동)',
              filled: true,
              fillColor: const Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.sapceGap * 3),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Constants.sapceGap * 3),
                  borderSide:
                      const BorderSide(width: 0, color: Color(0xFFE0E0E0))),
              prefixIcon: GestureDetector(
                onTap: () => {},
                child: const Icon(Icons.search, color: Colors.black),
              ),
              suffixIcon: Visibility(
                visible: _joinController.searchController.text.isNotEmpty,
                child: GestureDetector(
                  onTap: () => _joinController.searchClear(),
                  child: const Icon(
                    Icons.cancel,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 5,
          ),
          // const Button(
          //   text: '현재 위치로 찾기',
          //   isAccent: true,
          // ),
          const SizedBox(
            height: Constants.sapceGap * 6,
          ),
          Visibility(
            visible: _joinController.searchController.text.isNotEmpty,
            child: Text(
              "'${_joinController.searchController.text}' 검색 결과",
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 5,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _joinController.searchAddressList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _joinController.selectedLocation.value =
                        _joinController.searchAddressList[index].fullAddress!;
                    _joinController.moveNext();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Constants.sapceGap),
                    child: Text(
                      _joinController.searchAddressList[index].fullAddress!,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          Button(
            text: "다음",
            action: () {
              if (_joinController.validationLocation()) {
                _joinController.moveNext();
              }
            },
            isAccent: true,
          ),
        ],
      ),
    );
  }
}
