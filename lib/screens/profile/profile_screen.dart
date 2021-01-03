import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/my_products_controller.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/profile/components/body.dart';
import 'package:flutter_app/screens/user_screens/edit_profile_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen() {
    Get.put(MyProductsController()).getMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'profile'.tr,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: GestureDetector(
              onTap: () async {
                Get.to(EditProfileScreen());
              },
              child: Icon(
                Icons.edit,
                size: 25,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<MyProductsController>(
          builder: (controller) => controller.loading.value
              ? LoadingView()
              : GetBuilder<MainController>(
                  builder: (mainController) => Body(
                    user: mainController.user,
                    products: controller.products,
                  ),
                )),
    );
  }
}
