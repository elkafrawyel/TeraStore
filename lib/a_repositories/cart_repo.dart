import 'package:get/get.dart';
import 'package:tera/a_storage/network/products/products_service.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/data/responses/cart_response.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';

class CartRepo {
  getMyCartList({Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.getCartItems(),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          CartResponse cartResponse = CartResponse.fromJson(response.body);
          if (cartResponse.status) {
            state(Success(data: cartResponse.data));
          } else {
            state(Failure(errorMessage: 'Failed to get Cart Products'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get Cart Products'));
        }
      },
    );
  }

  addRemoveCart(String productId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.addRemoveCart(productId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            Get.find<CartController>().getCartItems();
            CommonMethods().showSnackBar(infoResponse.message);
            state(Success());
          } else {
            CommonMethods().showSnackBar(infoResponse.message);
            state(Failure(errorMessage: 'Failed to add or remove from Cart'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to add or remove from Cart'));
        }
      },
    );
  }

  cartItemPlusMinus(String productId, String action,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.cartItemPlusMinus(productId, action),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            Get.find<CartController>().getCartItems();
            // CommonMethods().showSnackBar(infoResponse.message);
            state(Success());
          } else {
            CommonMethods().showSnackBar(infoResponse.message);
            state(Failure(
                errorMessage: 'Failed to add or remove quantity from Cart'));
          }
        } catch (e) {
          print(e);
          state(Failure(
              errorMessage: 'Failed to add or remove quantity from Cart'));
        }
      },
    );
  }

  confirmOrder(String orderId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.confirmOrder(orderId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            Get.find<CartController>().getCartItems();
            CommonMethods().showSnackBar(infoResponse.message);
            state(Success());
          } else {
            CommonMethods().showSnackBar(infoResponse.message);
            state(Failure(errorMessage: 'Failed to confirm Order'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to confirm Order'));
        }
      },
    );
  }
}
