import 'package:flutter_app/core/controllers/FavouriteController.dart';
import 'package:flutter_app/core/controllers/add_product_controller.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/edit_product_controller.dart';
import 'package:flutter_app/core/controllers/general_controller.dart';
import 'package:flutter_app/core/controllers/home_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/core/controllers/products_controller.dart';
import 'package:flutter_app/core/controllers/profile_controller.dart';
import 'package:flutter_app/core/controllers/search_controller.dart';
import 'package:get/get.dart';

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
  }
}
