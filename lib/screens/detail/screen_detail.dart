import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/constants/key_store.dart';
import 'package:odm/controllers/controller_mating_actions.dart';
import 'package:odm/controllers/controller_mating_detail.dart';
import 'package:odm/screens/components/button.dart';
import 'package:odm/screens/components/detail_like_button.dart';
import 'package:odm/screens/components/mate_button.dart';
import 'package:odm/screens/detail/widgets/detail_added_tags.dart';
import 'package:odm/screens/detail/widgets/detail_apply_member.dart';
import 'package:odm/screens/detail/widgets/detail_join_member.dart';
import 'package:odm/screens/detail/widgets/detail_mating_time.dart';
import 'package:odm/screens/detail/widgets/header.dart';
import 'package:odm/screens/detail/widgets/section_title.dart';

class MateDetailScreen extends StatefulWidget {
  const MateDetailScreen({Key? key}) : super(key: key);

  @override
  State<MateDetailScreen> createState() => _MateDetailScreenState();
}

class _MateDetailScreenState extends State<MateDetailScreen> {
  final MatingDetailController _detailController = Get.find();
  final MatingActionController _controller = Get.find();

  final _storage = GetStorage();
  late String myId;
  int currentImageIndex = 1;
  bool isLike = false;

  @override
  void initState() {
    _detailController.setMate(Get.arguments);
    _detailController.getMateDetail(Get.arguments.sId!);
    myId = _storage.read(KeyStore.userID_I);
    isLike = _detailController.mateModel.value.isLike ?? false;

    super.initState();
  }

  void imageChanged(index, reason) {
    setState(() {
      currentImageIndex = index + 1;
    });
  }

  Widget getBottomBtns() {
    if (isMine()) {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
    if (applyedMate()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DetailLikeButton(
            isLike: isLike,
            iconSize: 30,
            click: () async {
              final state =
                  await _controller.updateLikeState(_detailController.mateId);
              setState(() {
                isLike = state;
              });
            },
          ),
          const SizedBox(
            width: Constants.sapceGap * 4,
          ),
          Expanded(
            child: Button(
              isAccent: true,
              action: () => _detailController.applyCancelMate(),
              text: '참가 취소',
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DetailLikeButton(
          isLike: isLike,
          iconSize: 30,
          click: () async {
            final state =
                await _controller.updateLikeState(_detailController.mateId);

            setState(() {
              isLike = state;
            });
          },
        ),
        const SizedBox(
          width: Constants.sapceGap * 4,
        ),
        Expanded(
          child: Button(
            isAccent: true,
            action: () => _detailController.appliedMate(),
            text: '참여하기',
          ),
        ),
      ],
    );
  }

  bool applyedMate() {
    if ((_detailController.mateModel.value.member?.appliedMember
                ?.indexWhere((element) => element.sId == myId) ??
            -1) >
        -1) {
      return true;
    }
    return false;
  }

  bool isMine() {
    if (myId == _detailController.mateModel.value.owner?.sId) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          '',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: DetailHeader(
                        images: _detailController.mateModel.value.images,
                        totalCount:
                            _detailController.mateModel.value.images?.length ??
                                0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.sapceGap * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: Constants.sapceGap * 5,
                          ),
                          SectionTitle(
                            owner: _detailController.mateModel.value.owner!,
                            title: _detailController.mateModel.value.title,
                            desc: _detailController.mateModel.value.message,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Constants.sapceGap * 8),
                            child: Divider(
                              height: 1,
                              color: ColorStore.color89,
                            ),
                          ),
                          MatingTimeSection(
                            maxMember:
                                _detailController.mateModel.value.memberLimit ??
                                    1,
                            location:
                                _detailController.mateModel.value.locationStr ??
                                    "",
                            date: _detailController.mateModel.value.mateDate ??
                                DateTime.now(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Constants.sapceGap * 8),
                            child: Divider(
                              height: 1,
                              color: ColorStore.color89,
                            ),
                          ),
                          JoinMembers(
                            isMine: isMine(),
                          ),
                          const SizedBox(
                            height: Constants.sapceGap * 4,
                          ),
                          ApplyMembers(
                            isMine: isMine(),
                          ),
                          const SizedBox(
                            height: Constants.sapceGap * 6,
                          ),
                          MateAddedTags(),
                          const SizedBox(
                            height: Constants.sapceGap * 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: Constants.sapceGap,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.sapceGap * 5,
                    vertical: Constants.sapceGap),
                child: getBottomBtns(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
