import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // controller.selectedTab = 0;
    await controller.getProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      builder: (controller) =>
          controller.loading.value || controller.productModel == null
              ? LoadingView()
              : Scaffold(
                  appBar: buildAppBar(),
                  body: Body(
                    product: controller.productModel,
                  ),
                ),
    );
  }

  buildAppBar() {
    return CustomAppBar(
      actions: [
        _favIcon(),
        BudgetCartIconView(
          press: () {
            Get.to(CartScreen());
          },
        ),
      ],
    );
  }

  _favIcon() {
    return controller.productModel == null
        ? GestureDetector(
            onTap: () {
              //add
              controller.addToFavourites(productId);
            },
            child: Icon(
              Icons.favorite_outline,
              color: Colors.white,
              size: 30,
            ),
          )
        : true
            ? GestureDetector(
                onTap: () {
                  //remove
                  controller.removeFromFavourites(productId);
                },
                child: Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              )
            : GestureDetector(
                onTap: () {
                  //add
                  controller.addToFavourites(productId);
                },
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 30,
                ),
              );
  }
}
