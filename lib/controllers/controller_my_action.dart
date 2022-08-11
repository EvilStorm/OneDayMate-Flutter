import 'package:flutter/material.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';
import 'package:odm/controllers/components/piece_mate_joined.dart';
import 'package:odm/controllers/components/piece_mate_like.dart';
import 'package:odm/controllers/components/piece_mate_mine.dart';
import 'package:odm/controllers/has_mate_list_abs.dart';

class MyActionsController extends GetxController
    with
        BasicControllorFunctions,
        GetSingleTickerProviderStateMixin,
        CreatedMatePiece,
        JoinedMatePiece,
        LikeMatePiece
    implements HasMateList {
  late TabController tabbarController;

  @override
  void onInit() {
    tabbarController = TabController(length: 3, vsync: this);

    getCreatedMate();
    getJoinedMate();
    getLinkMate();
    super.onInit();
  }

  @override
  void dataChanged() {
    // TODO: implement dataChanged
  }
}
