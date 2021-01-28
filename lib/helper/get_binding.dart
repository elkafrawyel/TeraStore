import 'package:get/get.dart';
import 'package:tera/controllers/FavouriteController.dart';
import 'package:tera/controllers/add_product_controller.dart';
import 'package:tera/controllers/auth_controller.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/edit_product_controller.dart';
import 'package:tera/controllers/general_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/controllers/orders_controller.dart';
import 'package:tera/controllers/product_details_controller.dart';
import 'package:tera/controllers/products_controller.dart';
import 'package:tera/controllers/profile_controller.dart';
import 'package:tera/controllers/search_controller.dart';
import 'package:tera/controllers/seller_controller.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
    Get.put(CartController(), permanent: true);

    /*  SmartManagement.full
    It is the default one. Dispose classes that are not being used and were not set to be permanent. In the majority of the cases you will want to keep this config untouched. If you new to GetX then don't change this.

    SmartManagement.onlyBuilders
    With this option, only controllers started in init: or loaded into a Binding with Get.lazyPut() will be disposed.

    If you use Get.put() or Get.putAsync() or any other approach, SmartManagement will not have permissions to exclude this dependency.
 */
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProductDetailsController());
    Get.lazyPut(() => AddProductController());
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => FavouriteController());
    Get.lazyPut(() => GeneralController());
    Get.lazyPut(() => EditProductController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => OrdersController());
    Get.lazyPut(() => SellerController());
  }
}
