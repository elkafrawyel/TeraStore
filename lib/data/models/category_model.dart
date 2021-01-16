import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/models/sub_category_model.dart';

class CategoryModel {
  int id;
  String nameAr;
  String nameEn;
  String image;
  List<SubCategoryModel> subCategories;

  CategoryModel(
      {this.id, this.nameAr, this.nameEn, this.image, this.subCategories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['categoryName'];
    nameAr = json['categoryNameAr'];
    image = json['categoryImage'];
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategoryModel>();
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.nameEn;
    data['categoryNameAr'] = this.nameAr;
    data['categoryImage'] = this.image;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String get displayName => LocalStorage().isArabicLanguage()
      ? (nameAr == null ? '' : nameAr)
      : (nameEn == null ? '' : nameEn);
}
