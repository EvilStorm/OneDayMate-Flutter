import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/has_mate_list_abs.dart';
import 'package:odm/models/model_mate.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class MainController extends GetxController
    with BasicControllorFunctions
    implements HasMateList {
  RxList<MateModel> mateList = <MateModel>[].obs;

  int pageCount = 0;

  @override
  void onInit() {
    getMainMate();
    super.onInit();
  }

  void getMainMate() async {
    final response = await HttpClient.instance.get("/main");

    if (response['code'] == 200) {
      mateList.value = (response['data'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
      Print.d(' mateList size : ${mateList.length}');
    }
  }

  void addMainMate(MateModel newMate) {
    mateList.insert(0, newMate);
  }

  @override
  void dataChanged() {
    mateList.refresh();
  }
}
