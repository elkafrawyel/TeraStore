import 'package:tera/data/models/category_model.dart';
import 'package:tera/data/models/product_model.dart';

class CategoriesWithSlidersResponse {
  bool status;
  String message;
  List<CategoryModel> categories;
  List<ProductModel> sliders;

  CategoriesWithSlidersResponse(
      {this.status, this.message, this.categories, this.sliders});

  CategoriesWithSlidersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = new List<CategoryModel>();
      json['categories'].forEach((v) {
        categories.add(new CategoryModel.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = new List<ProductModel>();
      json['sliders'].forEach((v) {
        sliders.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int id;
  String sCategoryName;
  String sCategoryImage;
  int catId;

  SubCategories({this.id, this.sCategoryName, this.sCategoryImage, this.catId});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sCategoryName = json['s_categoryName'];
    sCategoryImage = json['s_categoryImage'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['s_categoryName'] = this.sCategoryName;
    data['s_categoryImage'] = this.sCategoryImage;
    data['cat_id'] = this.catId;
    return data;
  }
}
