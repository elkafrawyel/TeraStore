import 'package:tera/a_storage/local_storage.dart';

class SubCategoryModel {
  String nameEn, nameAr, image;
  int id, categoryId;

  SubCategoryModel(
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.categoryId,
  );

  SubCategoryModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    id = map['id'];
    categoryId = map['cat_id'];
    nameAr = map['s_categoryNameAr'];
    nameEn = map['s_categoryName'];
    image = map['s_categoryImage'];
  }

  toJson() {
    return {
      'id': id,
      'cat_id': categoryId,
      's_categoryNameAr': nameAr,
      's_categoryName': nameEn,
      's_categoryImage': image,
    };
  }

  String get displayName => LocalStorage().isArabicLanguage() ? nameAr : nameEn;

  @override
  String toString() {
    return '\nid : $id \nname : $displayName';
  }
}
