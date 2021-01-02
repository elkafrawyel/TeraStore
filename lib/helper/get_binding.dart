import 'package:flutter_app/core/controllers/app_language_controller.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/explore_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/core/controllers/products_controller.dart';
import 'package:flutter_app/core/controllers/sub_category_controller.dart';
import 'package:get/get.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    //put not lazyPut to load and set locale immediately
    Get.put(AppLanguageController());

    Get.put(MainController(), permanent: true);

    Get.put(CartController(), permanent: true);

    Get.put(ExploreController());

    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SubCategoryController>(() => SubCategoryController());
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
  }
}
