import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/models/cart_model.dart';

class OrderResponse {
  bool status;
  List<Order> orders;

  OrderResponse({this.status, this.orders});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      orders = new List<Order>();
      json['data'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['data'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  String cartOrderStatus;
  String shippingAdress;
  int cartTotalPrice;
  int userId;
  List<CartItem> cartItems;

  Order(
      {this.id,
      this.cartOrderStatus,
      this.shippingAdress,
      this.cartTotalPrice,
      this.userId,
      this.cartItems});

  Order.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    id = json['id'];
    cartOrderStatus = json['cartOrderStatus'];
    shippingAdress = json['shippingAdress'];
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
    data['shippingAdress'] = this.shippingAdress;
    data['user_id'] = this.userId;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems.map((v) => v.toJson()).toList();
    }
    return data;
  }

  getOrderStatus() {
    bool isArabic = LocalStorage().isArabicLanguage();
    if (cartOrderStatus == 'primaryUserApprove') {
      return isArabic ? 'جاري المعالجة' : 'Processing';
    } else if (cartOrderStatus == 'acceptShipping') {
      return isArabic ? 'قيد التجهيز' : 'Getting ready';
    } else if (cartOrderStatus == 'operationDone') {
      return isArabic ? 'تم التجهيز' : 'Ready';
    } else if (cartOrderStatus == 'inShipping') {
      return isArabic ? 'جاري الشحن' : 'Shipping';
    } else if (cartOrderStatus == 'delayed') {
      return isArabic ? 'تأجيل' : 'Delayed';
    } else if (cartOrderStatus == 'canceled') {
      return isArabic ? 'تم الالغاء بواسطك' : 'Canceled by you';
    } else if (cartOrderStatus == 'delivered') {
      return isArabic ? 'تم التسليم' : 'Delivered to you';
    }
  }
}
