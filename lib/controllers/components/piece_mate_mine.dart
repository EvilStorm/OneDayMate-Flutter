import 'package:get/get.dart';
import 'package:odm/models/model_mate.dart';
import 'package:odm/network/http_client.dart';

class CreatedMatePiece {
  RxList<MateModel> createdMateList = <MateModel>[].obs;

  void getCreatedMate() async {
    final response = await HttpClient.instance.get("/mate/me/created/0");

    if (response['code'] == 200) {
      createdMateList.value = (response['data'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
    }
  }

  void createdMateRefresh() {
    createdMateList.refresh();
  }
}
