import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/product_details_controller.dart';
import 'package:tera/screens/custom_widgets/budget_cart_icon.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';

import '../cart_screen/cart_screen.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final String productId;

  DetailsScreen({this.productId}) {
    _loadDetails();
  }

  final controller = Get.find<ProductDetailsController>();

  _loadDetails() async {
    controller.selectedTab = 0;
    // await controller.getProductById('27');
    await controller.getProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalStorage().primaryColor(),
      appBar: buildAppBar(),
      body: GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(),
        builder: (controller) => controller.loading.value
            ? LoadingView()
            : Body(
                product: controller.productDetailsResponse.singleItem,
              ),
      ),
    );
  }

  buildAppBar() {
    return CustomAppBar(
      actions: [
        Icon(
          Icons.share,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        BudgetCartIconView(
          press: () {
            Get.to(CartScreen(),
                transition: Transition.upToDown,
                duration: Duration(milliseconds: 500));
          },
        ),
      ],
    );
  }
}
