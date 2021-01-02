import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/cart_model.dart';

class CartService {
  final CollectionReference _cartRef =
      FirebaseFirestore.instance.collection('Cart');
  final String userId = FirebaseAuth.instance.currentUser.uid;

  Future<CartModel> getMyCartList() async {
    DocumentSnapshot snapshot = await _cartRef.doc(userId).get();
    if (snapshot.exists) {
      CartModel cartModel = CartModel.fromJson(snapshot.data());
      if (cartModel != null) {
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
    Cart cart;
    int index;
    //get all list to modify and put it
    CartModel cartModel = await getMyCartList();
    for (int i = 0; i < cartModel.cart.length; i++) {
      if (cartModel.cart[i].id == productId) {
        cart = cartModel.cart[i];
        index = i;
      }
    }
    if (cart != null) {
      cartModel.cart[index].quantity++;
      await _cartRef.doc(userId).set(cartModel.toJson());
    } else {
      //add the product
      int time = DateTime.now().millisecondsSinceEpoch;
      cartModel.cart.add(Cart(id: productId, quantity: 1));
      await _cartRef.doc(userId).set(cartModel.toJson());
    }
  }

  //remove one by one
  removeFromCart(String productId) async {
    Cart cart;
    int index;
    //get all list to modify and put it
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
      await _cartRef.doc(userId).set(cartModel.toJson());
    }
  }

  //remove all quantity
  removeProductFromCart(String productId) async {
    Cart cart;
    int index;
    //get all list to modify and put it
    CartModel cartModel = await getMyCartList();
    for (int i = 0; i < cartModel.cart.length; i++) {
      if (cartModel.cart[i].id == productId) {
        cart = cartModel.cart[i];
        index = i;
      }
    }
    if (cart != null) {
      cartModel.cart.removeAt(index);
      await _cartRef.doc(userId).set(cartModel.toJson());
    }
  }
}
