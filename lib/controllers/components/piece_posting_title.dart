import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostingTitlePiece {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  var titlePageValidation = false.obs;

  void titleValidation() {
    if (titleTextController.text.isEmpty || descTextController.text.isEmpty) {
      titlePageValidation(false);
    }
    titlePageValidation(true);
  }
}
