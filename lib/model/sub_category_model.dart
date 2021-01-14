import 'package:tera/a_storage/local_storage.dart';

class SubCategoryModel {
  String id, nameEn, nameAr, image, categoryId;

  SubCategoryModel(this.nameEn, this.nameAr, this.image, this.categoryId);

  SubCategoryModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    categoryId = map['categoryId'];
    nameAr = map['nameAr'];
    nameEn = map['nameEn'];
    image = map['image'];
  }

  toJson() {
    return {
      'categoryId': categoryId,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'image': image,
    };
  }

  String get displayName => LocalStorage().isArabicLanguage() ? nameAr : nameEn;

  @override
  String toString() {
    return '\nid : $id \nname : $displayName';
  }
}
