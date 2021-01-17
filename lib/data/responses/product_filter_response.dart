import 'package:tera/data/models/product_model.dart';

class ProductsResponse {
  bool status;
  String message;
  List<ProductModel> data;

  ProductsResponse({this.status, this.message, this.data});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<ProductModel>();
      json['data'].forEach((v) {
        data.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
