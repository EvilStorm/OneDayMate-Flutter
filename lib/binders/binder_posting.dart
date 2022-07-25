import 'package:get/get.dart';
import 'package:odm/controllers/controller_posting.dart';

class PostingBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostingController());
  }
}
