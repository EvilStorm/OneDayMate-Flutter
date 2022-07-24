import 'package:odm/controllers/model_brief_user.dart';

class MateMemberModel {
  String? sId;
  // BriefUserModel? owner;
  String? mate;
  List<BriefUserModel>? appliedMember;
  List<BriefUserModel>? acceptedMember;
  List<BriefUserModel>? deniedMember;
  bool? isShow;
  String? createdAt;

  MateMemberModel(
      {this.sId,
      // this.owner,
      this.mate,
      this.appliedMember,
      this.acceptedMember,
      this.deniedMember,
      this.isShow,
      this.createdAt});

  MateMemberModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    // owner =
    //     json['owner'] != null ? BriefUserModel.fromJson(json['owner']) : null;
    mate = json['mate'];
    if (json['appliedMember'] != null) {
      appliedMember = <BriefUserModel>[];
      json['appliedMember'].forEach((v) {
        appliedMember!.add(BriefUserModel.fromJson(v));
      });
    }
    if (json['acceptedMember'] != null) {
      acceptedMember = <BriefUserModel>[];
      json['acceptedMember'].forEach((v) {
        acceptedMember!.add(BriefUserModel.fromJson(v));
      });
    }
    if (json['deniedMember'] != null) {
      deniedMember = <BriefUserModel>[];
      json['deniedMember'].forEach((v) {
        deniedMember!.add(BriefUserModel.fromJson(v));
      });
    }
    isShow = json['isShow'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    // if (owner != null) {
    //   data['owner'] = owner!.toJson();
    // }
    data['mate'] = mate;
    if (appliedMember != null) {
      data['appliedMember'] = appliedMember!.map((v) => v.toJson()).toList();
    }
    if (acceptedMember != null) {
      data['acceptedMember'] = acceptedMember!.map((v) => v.toJson()).toList();
    }
    if (deniedMember != null) {
      data['deniedMember'] = deniedMember!.map((v) => v.toJson()).toList();
    }
    data['isShow'] = isShow;
    data['createdAt'] = createdAt;
    return data;
  }
}
