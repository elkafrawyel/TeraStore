import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/FavouriteController.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/error_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/product_card.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

class FavouritesScreen extends StatelessWidget {
  final controller = Get.find<FavouriteController>();

  FavouritesScreen() {
    controller.getMyFavouriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
      init: FavouriteController(),
      builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            text: 'favorite'.tr,
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.loading.value
                  ? LoadingView()
                  : controller.empty.value
                      ? Center(
                          child: EmptyView(
                            message: 'noFavProducts'.tr,
                            emptyViews: EmptyViews.Box,
                            textColor: Colors.black,
                          ),
                        )
                      : controller.error.value
                          ? ErrorView()
                          : ListView.builder(
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  itemIndex: index,
                                  press: () {
                                    Get.to(
                                      DetailsScreen(
                                          productId: controller
                                              .products[index].id
                                              .toString()),
                                    );
                                  },
                                  onCartClicked: () {
                                    _addRemoveCart(controller.products[index]);
                                  },
                                  onFavouriteClicked: () {
                                    _addRemoveFavourite(
                                        controller.products[index]);
                                  },
                                  product: controller.products[index],
                                );
                              }),
            ),
          )),
    );
  }

  void _addRemoveFavourite(ProductModel product) {
    var controller = Get.find<FavouriteController>();
    Get.find<HomeController>().addRemoveFavourites(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct =
              controller.products[controller.products.indexOf(product)];
          myProduct.isFav = !myProduct.isFav;
          controller.update();
          //apply change in filter list
          Get.find<HomeController>()
              .changeFavouriteState(product.id.toString());
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }

  void _addRemoveCart(ProductModel product) {
    var controller = Get.find<FavouriteController>();
    Get.find<CartController>().addRemoveCart(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct =
              controller.products[controller.products.indexOf(product)];
          myProduct.inCart = !myProduct.inCart;
          controller.update();
          //apply change in filter list
          Get.find<HomeController>().changeInCartState(product.id.toString());
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }
}
