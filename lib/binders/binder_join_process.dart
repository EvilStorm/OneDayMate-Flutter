import 'package:get/get.dart';
import 'package:odm/controllers/controller_join.dart';

class JoinProcessBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JoinController());
  }
}
