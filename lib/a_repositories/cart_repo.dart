import 'package:flutter_app/model/cart_model.dart';

class CartRepo {
  Future<CartModel> getMyCartList() async {
    return CartModel(cart: []);
  }

  Future<void> addToCart(String productId) async {}

  //remove 1 quantity of a product and delete it if quantity is 0
  removeFromCart(String productId) async {}

  //remove a product from cart the all amount
  removeProductFromCart(String productId) async {}
}
