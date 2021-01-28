import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/controllers/profile_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/edit_profile_screen.dart';
import 'package:tera/screens/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen() {
    Get.find<ProfileController>().getMyProducts();
    Get.find<ProfileController>().getSellerInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'profile'.tr,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
            child: GestureDetector(
              onTap: () async {
                Get.to(
                  EditProfileScreen(),
                  transition: Transition.upToDown,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) => controller.loading.value
              ? LoadingView()
              : GetBuilder<MainController>(
                  builder: (mainController) => Body(
                    user: mainController.user,
                    products: controller.products,
                    myInformation: controller.myInformation,
                  ),
                )),
    );
  }
}
