import 'package:flutter_app/core/view_model/app_language_view_model.dart';
import 'package:flutter_app/core/view_model/auth_view_model.dart';
import 'package:flutter_app/core/view_model/cart_view_model.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/core/view_model/product_details_view_model.dart';
import 'package:flutter_app/core/view_model/products_view_model.dart';
import 'package:flutter_app/core/view_model/sub_category_view_model.dart';
import 'package:get/get.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    //put not lazyPut to load and set locale immediately
    Get.put(AppLanguageViewModel());

    Get.put(MainViewModel(), permanent: true);

    Get.lazyPut<CartViewModel>(() => CartViewModel());
    Get.lazyPut<AuthViewModel>(() => AuthViewModel());
    // Get.lazyPut<ExploreViewModel>(()=>ExploreViewModel());
    Get.lazyPut<SubCategoryViewModel>(() => SubCategoryViewModel());
    Get.lazyPut<ProductsViewModel>(() => ProductsViewModel());
    Get.lazyPut<ProductDetailsViewModel>(() => ProductDetailsViewModel());
    // Get.lazyPut<AddProductViewModel>(()=>AddProductViewModel());
  }
}
