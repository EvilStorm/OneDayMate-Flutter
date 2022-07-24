import 'package:get/get.dart';
import 'package:odm/models/model_tag_category.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class TagCategoryPiece {
  RxList<TagCategoryModel> categoryList = <TagCategoryModel>[].obs;

  RxList<int> selectedCategoryList = <int>[].obs;

  void setSelect(int index) {
    if (selectedCategoryList.contains(index)) {
      selectedCategoryList.remove(index);
    } else {
      if (selectedCategoryList.length >= 3) {
        return;
      }
      selectedCategoryList.add(index);
    }

    categoryList.refresh();
  }

  void getCategory() async {
    if (categoryList.isNotEmpty) return;

    var response = await HttpClient.instance.get(
      '/tagCategory',
    );

    if (response['code'] == 200) {
      categoryList.value = (response['data'] as List)
          .map((item) => TagCategoryModel.fromJson(item))
          .toList();
    }
  }
}
