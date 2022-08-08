import 'package:odm/models/model_brief_user.dart';
import 'package:odm/models/model_mate_member.dart';
import 'package:odm/models/model_category.dart';
import 'package:odm/models/model_tag.dart';

class MateModel {
  String? sId;
  BriefUserModel? owner;
  List<String>? images;
  String? title;
  String? message;
  int? memberLimit;
  String? locationStr;
  List<CategoryModel>? category;
  List<TagModel>? tags;
  bool? isShow;
  bool? isLike;
  bool? isPolice;
  DateTime? mateDate;
  DateTime? createdAt;
  MateMemberModel? member;

  MateModel(
      {this.sId,
      this.owner,
      this.images,
      this.title,
      this.message,
      this.memberLimit,
      this.locationStr,
      this.category,
      this.tags,
      this.isShow,
      this.isLike,
      this.isPolice,
      this.mateDate,
      this.createdAt,
      this.member});

  MateModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = BriefUserModel.fromJson(json['owner']);
    images = json['images'].cast<String>();
    title = json['title'];
    message = json['message'];
    memberLimit = json['memberLimit'];
    locationStr = json['locationStr'];
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((v) {
        category!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <TagModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
    isShow = json['isShow'];
    isLike = json['isLike'];
    isPolice = json['isPolice'];
    mateDate = DateTime.parse(json['mateDate']);
    createdAt = DateTime.parse(json['createdAt']);
    member = json['member'] != null
        ? MateMemberModel.fromJson(json['member'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['owner'] = owner;
    data['images'] = images;
    data['title'] = title;
    data['message'] = message;
    data['memberLimit'] = memberLimit;
    data['locationStr'] = locationStr;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['isShow'] = isShow;
    data['isLike'] = isLike;
    data['isPolice'] = isPolice;
    data['mateDate'] = mateDate;
    data['createdAt'] = createdAt;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    return data;
  }

  void setData(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = BriefUserModel.fromJson(json['owner'].toJson());
    images = json['images'].cast<String>();
    title = json['title'];
    message = json['message'];
    memberLimit = json['memberLimit'];
    locationStr = json['locationStr'];
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((v) {
        category!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <TagModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
    isShow = json['isShow'];
    isLike = json['isLike'];
    isPolice = json['isPolice'];
    mateDate = DateTime.parse(json['mateDate'].toString());
    createdAt = DateTime.parse(json['createdAt'].toString());
    member = json['member'] != null
        ? MateMemberModel.fromJson(json['member'])
        : null;
  }
}
