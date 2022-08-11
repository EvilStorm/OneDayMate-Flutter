import 'package:get/get.dart';
import 'package:odm/models/model_mate.dart';
import 'package:odm/network/http_client.dart';

class JoinedMatePiece {
  RxList<MateModel> joinedMateList = <MateModel>[].obs;

  void getJoinedMate() async {
    final response = await HttpClient.instance.get("/mate/me/applied/0");

    if (response['code'] == 200) {
      joinedMateList.value = (response['data'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
    }
  }

  void joinMateRefresh() {
    joinedMateList.refresh();
  }
}
