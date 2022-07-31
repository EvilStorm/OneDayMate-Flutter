import 'package:odm/controllers/basic_controller_fn.dart';
import 'package:odm/controllers/model_mate.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';
import 'package:get/get.dart';

class MatingDetailController extends GetxController
    with BasicControllorFunctions {
  var mateModel = MateModel().obs;
  late String mateId;
  Future<bool> getMateDetail(String mId) async {
    mateId = mId;

    try {
      var response = await HttpClient.instance.get('/mate/detail/$mId');

      if (response['code'] == 200) {
        mateModel.value = MateModel.fromJson(response['data']);
        return true;
      } else {
        showMessage(response['message']);
        return false;
      }
    } catch (e) {
      Print.e(e);
      return false;
    }
  }

  void setMate(MateModel _model) {
    mateModel.value = _model;
  }

  void appliedMate() async {
    showLoadingDialog();
    try {
      var response =
          await HttpClient.instance.post('/mate/apply/$mateId', body: {});
      if (response['code'] == 200) {
        await getMateDetail(mateId);
      }
    } catch (e) {
      Print.e(e);
    } finally {
      hideLoadingDialog();
    }
  }

  void applyCancelMate() async {
    showLoadingDialog();
    try {
      var response = await HttpClient.instance
          .post('/mate/apply/cancel/$mateId', body: {});
      if (response['code'] == 200) {
        await getMateDetail(mateId);
      }
    } catch (e) {
      Print.e(e);
    } finally {
      hideLoadingDialog();
    }
  }

  void acceptCancel(String sId) async {
    try {
      var response = await HttpClient.instance.post(
        '/mate/accept/cancel/${mateModel.value.sId}',
        body: {
          'userId': sId,
        },
      );
      if (response['code'] == 200) {
        removeMember(sId);
      }
    } catch (e) {
      Print.e(e);
    }
  }

  void removeMember(String mId) {
    int? index = mateModel.value.member?.acceptedMember
        ?.indexWhere((element) => element.sId == mId);

    if (index != null && index >= 0) {
      mateModel.value.member?.acceptedMember?.removeAt(index);
    }
    mateModel.refresh();
  }

  void moveJoinMember(String userId) {
    int? index = mateModel.value.member?.appliedMember
        ?.indexWhere((element) => element.sId == userId);

    if (index != null && index >= 0) {
      mateModel.value.member?.acceptedMember
          ?.add(mateModel.value.member!.appliedMember!.elementAt(index));
    }
    mateModel.refresh();
  }

  void acceptedMember(String userId) async {
    try {
      var response = await HttpClient.instance.post(
        '/mate/accept/${mateModel.value.sId}',
        body: {
          'acceptedId': userId,
        },
      );
      if (response['code'] == 200) {
        moveJoinMember(userId);
      } else {
        showMessage(response['message']);
      }
    } catch (e) {
      Print.e(e);
    }
  }

  void memberDenied(String sId) async {
    try {
      var response = await HttpClient.instance.post('/mate/join/cancel/$sId');
      if (response['code'] == 200) {}
    } catch (e) {
      Print.e(e);
    }
  }
}
