import 'package:get/get.dart';
import 'package:odm/controllers/controller_home.dart';
import 'package:odm/controllers/controller_main.dart';
import 'package:odm/controllers/controller_mating_actions.dart';
import 'package:odm/controllers/controller_my_action.dart';
import 'package:odm/controllers/controller_my_info.dart';

class HomeBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => MyInfoController());
    Get.lazyPut(() => MatingActionController());
    Get.lazyPut(() => MyActionsController());
  }
}
