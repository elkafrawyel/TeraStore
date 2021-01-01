import 'package:flutter_app/core/services/sub_category_service.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/model/sub_category_model.dart';

class SubCategoryViewModel extends MainViewModel {
  List<SubCategoryModel> _subCategories = [];

  List<SubCategoryModel> get subCategories => _subCategories;

  getSubCategories(String categoryId) async {
    loading.value = true;
    _subCategories.clear();
    SubCategoryService().getSubCategories(categoryId).then((docs) {
      docs.forEach((element) {
        SubCategoryModel subCategoryModel =
            SubCategoryModel.fromJson(element.data());
        subCategoryModel.id = element.id;
        _subCategories.add(subCategoryModel);
        print('Sub category model => $subCategoryModel');
      });
      loading.value = false;
      if (_subCategories.isEmpty) {
        empty.value = true;
      } else {
        empty.value = false;
      }
      print('SubCategories => ${_subCategories.length}');
      update();
    });
  }
}
