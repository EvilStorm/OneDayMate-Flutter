import 'package:odm/models/model_tag.dart';

class CategoryModel {
  String? sId;
  String? category;
  int? type;
  String? iconUrl;
  List<TagModel>? tags;

  CategoryModel({this.sId, this.category, this.type, this.iconUrl, this.tags});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    type = json['type'];
    iconUrl = json['iconUrl'];
    if (json['tags'] != null) {
      tags = <TagModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    data['type'] = type;
    data['iconUrl'] = iconUrl;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
