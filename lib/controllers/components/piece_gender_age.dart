import 'package:get/get.dart';

enum Gender { MALE, FEMALE }

class GenderAgePiece {
  Rx<Gender> gender = Rx<Gender>(Gender.MALE);

  var age = 20.0.obs;
}
