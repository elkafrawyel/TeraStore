import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/model/cart_model.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

class CartService {
  final CollectionReference _cartRef = Firestore.instance.collection('Cart');

  Future<CartModel> getMyCartList() async {
    DocumentSnapshot snapshot = await _cartRef
        .document(LocalStorage().getString(LocalStorage.userId))
        .get();
    if (snapshot.exists) {
      CartModel cartModel =
          CartModel.fromJson(Map<String, dynamic>.from(snapshot.data));
      if (cartModel != null &&
          cartModel.cart != null &&
          cartModel.cart.isNotEmpty) {
        print('cart list => ${cartModel.cart.length}');
        return cartModel;
      } else {
        return CartModel(cart: []);
      }
    } else {
      return CartModel(cart: []);
    }
  }

  Future<void> addToCart(String productId) async {
    //Adding products into cart one by one only put the id
    Cart cart;
    int index;
    CartModel cartModel = await getMyCartList();
    for (int i = 0; i < cartModel.cart.length; i++) {
      if (cartModel.cart[i].id == productId) {
        cart = cartModel.cart[i];
        index = i;
      }
    }
    if (cart != null) {
      cartModel.cart[index].quantity++;
      await _cartRef
          .document(Get.find<MainController>().user.id)
          .setData(cartModel.toJson());
      print('Items is added to cart');
    } else {
      cartModel.cart.add(Cart(id: productId, quantity: 1));
      await _cartRef
          .document(LocalStorage().getString(LocalStorage.userId))
          .setData(cartModel.toJson());
    }
  }

  //remove 1 quantity of a product and delete it if quantity is 0
  removeFromCart(String productId) async {
    Cart cart;
    int index;
    CartModel cartModel = await getMyCartList();
    for (int i = 0; i < cartModel.cart.length; i++) {
      if (cartModel.cart[i].id == productId) {
        cart = cartModel.cart[i];
        index = i;
      }
    }
    if (cart != null) {
      cartModel.cart[index].quantity--;
      if (cartModel.cart[index].quantity == 0) {
        cartModel.cart.removeAt(index);
      }
      await _cartRef
          .document(LocalStorage().getString(LocalStorage.userId))
          .setData(cartModel.toJson());
      print('Items is removed from cart');
    }
  }

  //remove a product from cart the all amount
  removeProductFromCart(String productId) async {
    Cart cart;
    int index;
    CartModel cartModel = await getMyCartList();
    for (int i = 0; i < cartModel.cart.length; i++) {
      if (cartModel.cart[i].id == productId) {
        cart = cartModel.cart[i];
        index = i;
      }
    }
    if (cart != null) {
      cartModel.cart.removeAt(index);
      await _cartRef
          .document(LocalStorage().getString(LocalStorage.userId))
          .setData(cartModel.toJson());
    }
    print('Items is removed from cart');
  }
}
