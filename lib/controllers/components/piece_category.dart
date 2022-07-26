import 'package:get/get.dart';
import 'package:odm/models/model_category.dart';
import 'package:odm/network/http_client.dart';
import 'package:odm/utils/print.dart';

class CategoryPiece {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<int> selectedCategoryList = <int>[].obs;
  var maxSelectedCount = 3;

  void setSelectedMaxCount(int count) {
    maxSelectedCount = count;
  }

  void setSingleSelect(int index) {
    if (categoryList.isNotEmpty) {
      selectedCategoryList.clear();
    }
    selectedCategoryList.add(index);

    categoryList.refresh();
  }

  void setSelect(int index) {
    if (selectedCategoryList.contains(index)) {
      selectedCategoryList.remove(index);
    } else {
      if (selectedCategoryList.length >= maxSelectedCount) {
        return;
      }
      selectedCategoryList.add(index);
    }

    categoryList.refresh();
  }

  void getCategory() async {
    if (categoryList.isNotEmpty) return;

    var response = await HttpClient.instance.get(
      '/category',
    );

    if (response['code'] == 200) {
      categoryList.value = (response['data'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
    }
  }
}
