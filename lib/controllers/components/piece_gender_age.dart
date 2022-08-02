import 'package:get/get.dart';

enum Gender { male, female }

class GenderAgePiece {
  Rx<Gender> gender = Rx<Gender>(Gender.male);

  var age = 20.0.obs;
}
