import 'package:get/get.dart';
import 'package:odm/models/model_mate.dart';
import 'package:odm/network/http_client.dart';

class LikeMatePiece {
  RxList<MateModel> likeMateList = <MateModel>[].obs;

  void getLinkMate() async {
    final response = await HttpClient.instance.get("/mate/me/like/0");

    if (response['code'] == 200) {
      likeMateList.value = (response['data'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
    }
  }

  void likeMateRefresh() {
    likeMateList.refresh();
  }
}
