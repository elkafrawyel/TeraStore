import 'package:get/get.dart';
import 'package:tera/a_repositories/cart_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/responses/cart_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';

class CartController extends MainController {
  //if a current call is running
  bool opRunning = false;
  Cart cart;
  var cartCount = 0;

  Future<void> addRemoveCart(String productId,
      {Function(DataResource dataResource) state}) async {
    if (opRunning) return;
    opRunning = true;
    CartRepo().addRemoveCart(productId, state: state);
    opRunning = false;
  }

  Future<void> getCartItems({bool showLoading = false}) async {
    loading.value = showLoading;
    update();
    CartRepo().getMyCartList(
      state: (dataResource) {
        if (dataResource is Success) {
          cart = dataResource.data as Cart;
          if (cart != null) {
            cartCount = cart.cartItems.length;
            print('cart count => $cartCount');
            loading.value = false;
            empty.value = cart.cartItems.isEmpty;
            update();
          } else {
            cartCount = 0;
            print('cart count => $cartCount');
            loading.value = false;
            empty.value = true;
            update();
          }
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr);
          loading.value = false;
          update();
        }
      },
    );
  }

  void removeItem(String productId, {int index, bool showLoading}) async {
    if (opRunning) return;
    opRunning = true;

    opRunning = false;
  }
}
