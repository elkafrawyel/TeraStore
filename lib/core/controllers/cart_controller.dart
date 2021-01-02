import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/cart_service.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/cart_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:get/get.dart';

class CartController extends MainController {
  bool opRunning = false;
  List<Cart> _products = [];

  List<Cart> get products => _products;

  int cartCount = 0;

  @override
  onInit() {
    super.onInit();
    getCartItems();
  }

  getCartItems() async {
    if (loading.value) {
      return;
    }
    loading.value = true;
    _products.clear();
    CartModel cartModel = await CartService().getMyCartList();
    for (Cart cart in cartModel.cart) {
      ProductModel model = await getProductById(cart.id);
      cart.productModel = model;
      _products.add(cart);
    }
    print('cart Size => ${_products.length}');
    loading.value = false;
    if (_products.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    cartCount = _products.length;
    update();
  }

  Future<ProductModel> getProductById(String productId) async {
    ProductModel productModel;
    DocumentSnapshot snapshot =
        await ProductService().getProductById(productId);
    if (snapshot.exists) {
      productModel = ProductModel.fromJson(snapshot.data());
      //get product owner
      DocumentSnapshot userSnapShot =
          await UserService().getUser(productModel.userId);
      UserModel owner = UserModel.fromJson(userSnapShot.data());
      productModel.owner = owner;

      productModel.isFav = true;
    }
    print('cart product : $productModel');
    return productModel;
  }

  Future<void> addToCart(ProductModel product,
      {int index = -1, bool shouldUpdate = false}) async {
    if (opRunning) return;
    opRunning = true;
    await CartService().addToCart(product.id);
    if (index != -1) {
      _products[index].quantity++;
    }
    if (shouldUpdate) {
      getCartItems();
    }
    opRunning = false;
    update();
  }

  Future<void> deleteFromCart(String productId, {int index}) async {
    if (opRunning) return;
    opRunning = true;
    await CartService().removeFromCart(productId);
    _products[index].quantity--;
    if (_products[index].quantity == 0) {
      _products.removeAt(index);
    }
    if (_products.length == 0) {
      empty.value = true;
    }
    cartCount = _products.length;
    opRunning = false;
    update();
  }

  void removeItem(String productId, int index) async {
    if (opRunning) return;
    opRunning = true;
    await CartService().removeProductFromCart(productId);
    _products.removeAt(index);
    if (_products.length == 0) {
      empty.value = true;
    }
    cartCount = _products.length;
    opRunning = false;
    update();
  }
}
