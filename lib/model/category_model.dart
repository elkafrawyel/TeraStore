import 'package:flutter_app/helper/local_storage.dart';

class CategoryModel {
  String id, nameAr, nameEn, image;

  CategoryModel(this.nameAr, this.nameEn, this.image);

  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    nameAr = map['nameAr'];
    nameEn = map['nameEn'];
    image = map['image'];
  }

  toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'image': image,
    };
  }

  String get displayName => LocalStorage().isArabicLanguage() ? nameAr : nameEn;

  @override
  String toString() {
    return 'id : $id - name : $nameAr - image : $image ';
  }
}
