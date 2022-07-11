import 'package:odm/models/model_setting.dart';

class UserModel {
  String? sId;
  String? email;
  String? identifyId;
  String? nickName;
  bool? gender;
  int? age;
  int? secureLevel;
  String? pictureMe;
  String? aboutMe;
  String? pushToken;
  SettingModel? setting;
  DateTime? createdAt;

  UserModel(
      {this.sId,
      this.email,
      this.identifyId,
      this.nickName,
      this.gender,
      this.age,
      this.secureLevel,
      this.pictureMe,
      this.aboutMe,
      this.pushToken,
      this.setting,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    identifyId = json['identifyId'];
    nickName = json['nickName'];
    gender = json['gender'];
    age = json['age'];
    secureLevel = json['secureLevel'];
    pictureMe = json['pictureMe'];
    aboutMe = json['aboutMe'];
    pushToken = json['pushToken'];
    setting =
        json['setting'] != null ? SettingModel.fromJson(json['setting']) : null;
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['identifyId'] = identifyId;
    data['nickName'] = nickName;
    data['gender'] = gender;
    data['age'] = age;
    data['secureLevel'] = secureLevel;
    data['pictureMe'] = pictureMe;
    data['aboutMe'] = aboutMe;
    data['pushToken'] = pushToken;
    if (setting != null) {
      data['setting'] = setting!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}
