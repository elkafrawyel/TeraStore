import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/cart_service.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/model/cart_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/user_model.dart';

class CartController extends MainController {
  //if a current call is running
  bool opRunning = false;
  List<Cart> _products = [];

  List<Cart> get products => _products;
  var cartCount = 0;

  @override
  onInit() {
    super.onInit();
    getCartItems();
  }

  getCartItems({bool showLoading = false}) async {
    loading.value = showLoading;
    update();
    _products.clear();

    CartModel cartModel = await CartService().getMyCartList();

    for (Cart cart in cartModel.cart) {
      ProductModel model = await getProductById(cart.id);
      cart.productModel = model;
      _products.add(cart);
    }

    loading.value = false;

    if (_products.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }

    cartCount = _products.length;
    print('cart count => $cartCount');

    update();
  }

  Future<ProductModel> getProductById(String productId) async {
    ProductModel productModel;
    DocumentSnapshot snapshot =
        await ProductService().getProductById(productId);
    if (snapshot.exists) {
      productModel = ProductModel.fromJson(snapshot.data);
      //get product owner
      DocumentSnapshot userSnapShot =
          await UserService().getUser(productModel.userId);
      UserModel owner = UserModel.fromJson(userSnapShot.data);

      productModel.owner = owner;

      await ProductService().checkIfFavourite(productId, (value) {
        productModel.isFav = value;
      });
    }
    return productModel;
  }

  Future<void> addToCart(ProductModel product,
      {int index = -1, bool showLoading = false}) async {
    if (opRunning) return;

    opRunning = true;

    await CartService().addToCart(product.id);

    getCartItems(showLoading: showLoading);

    opRunning = false;
  }

  Future<void> deleteFromCart(String productId,
      {int index, bool showLoading}) async {
    if (opRunning) return;

    opRunning = true;

    await CartService().removeFromCart(productId);

    getCartItems(showLoading: showLoading);

    opRunning = false;
  }

  void removeItem(String productId, {int index, bool showLoading}) async {
    if (opRunning) return;

    opRunning = true;

    await CartService().removeProductFromCart(productId);

    getCartItems(showLoading: showLoading);

    opRunning = false;
  }
}
