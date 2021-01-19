import 'package:tera/data/models/cart_model.dart';

class CartResponse {
  bool status;
  Cart data;

  CartResponse({this.status, this.data});

  CartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Cart.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Cart {
  int id;
  String cartOrderStatus;
  int cartTotalPrice;
  int userId;
  List<CartItem> cartItems;

  Cart(
      {this.id,
      this.cartOrderStatus,
      this.cartTotalPrice,
      this.userId,
      this.cartItems});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    id = json['id'];
    cartOrderStatus = json['cartOrderStatus'];
    cartTotalPrice = json['cartTotalPrice'];
    userId = json['user_id'];
    if (json['cart_items'] != null) {
      cartItems = new List<CartItem>();
      json['cart_items'].forEach((v) {
        cartItems.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartOrderStatus'] = this.cartOrderStatus;
    data['cartTotalPrice'] = this.cartTotalPrice;
    data['user_id'] = this.userId;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
