import 'package:get/get.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/models/model_mate.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class MatingActionController extends GetxController
    with BasicControllorFunctions {
  Future<MateModel?> updateLikeState(String mateId) async {
    try {
      var response = await HttpClient.instance
          .patch('/mate/like', body: {'mateId': mateId});

      if (response['code'] == 200) {
        // MateModel.fromJson(item)
        MateModel model = MateModel.fromJson(response['data'][0]);
        return model;
      } else {
        showMessage(response['data']['message']);
        return null;
      }
    } catch (e) {
      Print.e(e);
    }
    return null;
  }
}
