import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odm/constants/color_store.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/constants/key_store.dart';
import 'package:odm/controllers/controller_mating_detail.dart';
import 'package:odm/screens/components/mate_button.dart';
import 'package:odm/screens/components/user_brief_info.dart';
import 'package:odm/screens/detail/widgets/detail_added_tags.dart';
import 'package:odm/screens/detail/widgets/detail_apply_member.dart';
import 'package:odm/screens/detail/widgets/detail_join_member.dart';
import 'package:odm/screens/detail/widgets/detail_mating_time.dart';
import 'package:odm/screens/components/sliver_header.dart';
import 'package:odm/screens/detail/widgets/header.dart';
import 'package:odm/screens/detail/widgets/section_header_20.dart';
import 'package:odm/screens/detail/widgets/section_title.dart';

class MateDetailScreen extends StatefulWidget {
  const MateDetailScreen({Key? key}) : super(key: key);

  @override
  State<MateDetailScreen> createState() => _MateDetailScreenState();
}

class _MateDetailScreenState extends State<MateDetailScreen> {
  final MatingDetailController _detailController = Get.find();

  // late MateModel _passingModel;
  late double defaultDetailHeight;
  double detailHeight = 0;
  double dragStartPos = 0;
  double newHeight = 0;
  late double totalHeight;

  CarouselController buttonCarouselController = CarouselController();
  final _storage = GetStorage();
  late String myId;

  @override
  void initState() {
    // _passingModel = Get.arguments;
    // logError("_passingModel : ${Get.arguments.sId}");
    _detailController.setMate(Get.arguments);
    _detailController.getMateDetail(Get.arguments.sId!);
    myId = _storage.read(KeyStore.userID_I);

    super.initState();
  }

  int currentImageIndex = 1;
  void imageChanged(index, reason) {
    setState(() {
      currentImageIndex = index + 1;
    });
  }

  void dragStart(DragStartDetails details) {
    dragStartPos = details.localPosition.dy;
  }

  void dragUp(DragUpdateDetails details) {
    newHeight = detailHeight + (dragStartPos - details.localPosition.dy) / 15;
    if (newHeight < defaultDetailHeight) {
      newHeight = detailHeight;
    }
    if (newHeight >= totalHeight) {
      newHeight = totalHeight;
    }

    setState(() {
      detailHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    totalHeight = MediaQuery.of(context).size.height * 0.85;
    defaultDetailHeight = MediaQuery.of(context).size.height * 0.6;
    if (detailHeight == 0) {
      detailHeight = defaultDetailHeight;
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                // SliverAppBar(
                //   backgroundColor: ColorStore.primaryColor,
                //   pinned: true,
                //   expandedHeight: 300,
                //   flexibleSpace: FlexibleSpaceBar(
                //     background: DetailHeader(
                //       images: [
                //         'http://www.stardailynews.co.kr/news/photo/202105/298354_341867_3158.jpg',
                //         'https://cdn.entermedia.co.kr/news/photo/202106/26462_48613_153.jpg',
                //         'https://t1.daumcdn.net/cfile/tistory/994EBB345DCC1C2718'
                //       ],
                //       totalCount: 3,
                //     ),
                //   ),
                // ),
                SliverPersistentHeader(
                  delegate: SliverHeader(
                      child: DetailHeader(
                        images: [
                          'https://image.mycelebs.com/celeb/sq/340_sq_01.jpg',
                          'https://cdn.gukjenews.com/news/photo/202102/2163320_2156511_1710.jpg'
                        ],
                        totalCount: 2,
                      ),
                      minHeight: 120,
                      maxHeight: 300),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(
                        height: Constants.sapceGap * 2,
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
                            _detailController.mateModel.value.memberLimit ?? 1,
                        location:
                            _detailController.mateModel.value.locationStr ?? "",
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
                      JoinMembers(
                        isMine: isMine(),
                      ),
                      JoinMembers(
                        isMine: isMine(),
                      ),
                      JoinMembers(
                        isMine: isMine(),
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
          Obx(() => getBottomBtns()),
          const SizedBox(
            height: Constants.sapceGap * 4,
          )
        ],
      ),
    );
  }

  Widget getBottomBtns() {
    // if (isMine()) {
    //   return const SizedBox(
    //     width: 0,
    //     height: 0,
    //   );
    // }
    if (applyedMate()) {
      return MateButton(
        onClick: () => _detailController.joinCancelMate(),
        text: '참가 취소',
      );
    }

    return MateButton(
      onClick: () => _detailController.joinMate(),
      text: '참여하기',
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
}
