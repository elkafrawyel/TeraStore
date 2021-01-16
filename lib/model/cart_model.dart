import 'package:tera/data/models/product_model.dart';

class CartModel {
  List<Cart> cart;

  CartModel({this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = List<Cart>.empty(growable: true);
      json['cart'].forEach((v) {
        cart.add(Cart.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  String id;
  int quantity;
  ProductModel productModel;

  Cart({this.id, this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    return data;
  }
}
