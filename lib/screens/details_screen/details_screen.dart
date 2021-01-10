import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/screens/custom_widgets/budget_cart_icon.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:get/get.dart';
import '../cart_screen/cart_screen.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final String productId;

  DetailsScreen({this.productId}) {
    _loadDetails();
  }

  _loadDetails() async {
    var controller = Get.put(ProductDetailsController());
    controller.selectedTab = 0;
    await controller.getProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (controller) =>
          controller.loading.value || controller.productModel == null
              ? LoadingView()
              : Scaffold(
                  // backgroundColor: LocalStorage().primaryColor(),
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
        _favIcon(controller),
        BudgetCartIconView(
          press: () {
            Get.to(CartScreen());
          },
        ),
      ],
    );
  }

  _favIcon(ProductDetailsController controller) {
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
        : controller.productModel.isFav
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
