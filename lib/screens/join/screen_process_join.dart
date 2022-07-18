import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:odm/controllers/controller_brief_addr.dart';
import 'package:odm/controllers/controller_sign.dart';
import 'package:odm/models/model_brief_addr.dart';
import 'package:odm/screens/components/button.dart';

class JoinProcessScreen extends StatelessWidget {
  JoinProcessScreen({Key? key}) : super(key: key);

  final SignController _signController = Get.find();
  final BirefAddressSearchController _addrSearchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '어디에 살고있나요?',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: Constants.sapceGap * 3,
            ),
            Text(
              '설정한 주소를 기반으로\n내 근처 모임을 알려드릴께요.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: Constants.sapceGap * 6,
            ),
            TextField(
              controller: _addrSearchController.searchController,
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
                suffixIcon: GestureDetector(
                  onTap: () => _addrSearchController.searchClear(),
                  child: const Icon(
                    Icons.cancel,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: Constants.sapceGap * 5,
            ),
            Button(
              text: '현재 위치로 찾기',
              isAccent: true,
            ),
            const SizedBox(
              height: Constants.sapceGap * 6,
            ),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: _addrSearchController.searchAddressList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Constants.sapceGap),
                      child: Text(
                        _addrSearchController
                            .searchAddressList[index].fullAddress!,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
