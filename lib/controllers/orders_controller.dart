import 'package:get/get.dart';
import 'package:tera/a_repositories/cart_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/responses/order_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';

class OrdersController extends MainController {
  List<Order> orders = [];

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  getOrders() async {
    loading.value = true;
    update();
    CartRepo().getMyOrders(
      state: (dataResource) {
        if (dataResource is Success) {
          orders.clear();
          orders = dataResource.data as List<Order>;
          if (orders != null) {
            print('order count => ${orders.length}');
            loading.value = false;
            empty.value = orders.isEmpty;
            update();
          } else {
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

  @override
  void onClose() {
    print('close=======>');
    super.onClose();
  }

  deleteOrder(String orderId) async {
    loading.value = true;
    update();
    CartRepo().deleteOrder(
      orderId,
      state: (dataResource) {
        if (dataResource is Success) {
          getOrders();
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr);
          loading.value = false;
          update();
        }
      },
    );
  }
}
