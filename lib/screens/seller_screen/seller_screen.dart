import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/seller_controller.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';

import 'components/body.dart';

class SellerScreen extends StatelessWidget {
  final UserModel userModel;

  final controller = Get.find<SellerController>();

  SellerScreen({this.userModel}) {
    controller.userModel = userModel;
    controller.getSellerInformation();
    controller.getSellerProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'sellerInfo'.tr,
      ),
      body: GetBuilder<SellerController>(
        init: SellerController(),
        builder: (controller) => controller.loading.value
            ? LoadingView()
            : Body(
                user: userModel,
                sellerInformation: controller.sellerInformation,
                products: controller.products,
              ),
      ),
    );
  }
}
