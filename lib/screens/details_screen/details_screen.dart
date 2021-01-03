import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/cart_screen.dart';
import 'package:flutter_app/screens/custom_widgets/budget_cart_icon.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:get/get.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final String productId;

  DetailsScreen({this.productId}) {
    _loadDetails();
  }

  _loadDetails() async {
    await Get.put(ProductDetailsController()).getProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (controller) => controller.loading.value
          ? LoadingView()
          : Scaffold(
              backgroundColor: primaryColor,
              appBar: buildAppBar(context, controller),
              body: Body(
                product: controller.productModel,
              ),
            ),
    );
  }

  buildAppBar(BuildContext context, ProductDetailsController controller) {
    return CustomAppBar(
      actions: [
        controller.productModel.isFav
            ? GestureDetector(
                onTap: () {
                  //remove
                  controller.removeFromFavourites(productId);
                },
                child: Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
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
                ),
              ),
        BudgetCartIconView(
          press: () {
            Get.to(CartScreen());
          },
        ),
      ],
    );
  }
}
