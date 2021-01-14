import 'package:tera/controllers/main_controller.dart';
import 'package:tera/model/cart_model.dart';
import 'package:tera/model/product_model.dart';

class CartController extends MainController {
  //if a current call is running
  bool opRunning = false;
  List<Cart> _products = [];

  List<Cart> get products => _products;
  var cartCount = 0;

  Future<void> getCartItems({bool showLoading = false}) async {
    loading.value = showLoading;
    update();
    _products.clear();

    cartCount = _products.length;
    print('cart count => $cartCount');

    update();
  }

  Future<void> addToCart(ProductModel product,
      {int index = -1, bool showLoading = false}) async {
    if (opRunning) return;
    opRunning = true;

    opRunning = false;
  }

  Future<void> deleteFromCart(String productId,
      {int index, bool showLoading}) async {
    if (opRunning) return;

    opRunning = true;

    opRunning = false;
  }

  void removeItem(String productId, {int index, bool showLoading}) async {
    if (opRunning) return;

    opRunning = true;

    opRunning = false;
  }
}
