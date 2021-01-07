import 'package:flutter_app/core/controllers/app_language_controller.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:get/get.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    //put not lazyPut to load and set locale immediately
    Get.put(AppLanguageController());

    Get.put(MainController(), permanent: true);

    Get.put(CartController(), permanent: true);
  }
}
