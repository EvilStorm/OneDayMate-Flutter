import 'package:get/get.dart';
import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class MatingActionController extends GetxController
    with BasicControllorFunctions {
  Future<bool> updateLikeState(String mateId) async {
    try {
      var response = await HttpClient.instance
          .patch('/mate/like', body: {'mateId': mateId});

      if (response['code'] == 200) {
        return response['data']['value'];
      } else {
        showMessage(response['data']['message']);
        return false;
      }
    } catch (e) {
      Print.e(e);
    }
    return false;
  }
}
