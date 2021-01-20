import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/products_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/error_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/product_card.dart';
import 'package:tera/screens/custom_widgets/product_card_grid.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      init: ProductsController(),
      builder: (controller) => controller.loading.value
          ? LoadingView()
          : controller.empty.value
              ? Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: EmptyView(
                    message: 'noProductsFound'.tr,
                  ),
                )
              : controller.error.value
                  ? ErrorView()
                  : Container(
                      // color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: controller.isGrid
                            ? GridView.builder(
                                itemCount: controller.products.length,
                                itemBuilder: (context, index) {
                                  return ProductCardGrid(
                                    itemIndex: index,
                                    product: controller.products[index],
                                    press: () {
                                      Get.to(
                                        DetailsScreen(
                                            productId: controller
                                                .products[index].id
                                                .toString()),
                                      );
                                    },
                                    onCartClicked: () {
                                      _addRemoveCart(
                                          controller.products[index]);
                                    },
                                    onFavouriteClicked: () {
                                      _addRemoveFavourite(
                                          controller.products[index]);
                                    },
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.5,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 1),
                              )
                            : ListView.builder(
                                itemCount: controller.products.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    itemIndex: index,
                                    product: controller.products[index],
                                    press: () {
                                      Get.to(
                                        DetailsScreen(
                                            productId: controller
                                                .products[index].id
                                                .toString()),
                                      );
                                    },
                                    onCartClicked: () {
                                      _addRemoveCart(
                                          controller.products[index]);
                                    },
                                    onFavouriteClicked: () {
                                      _addRemoveFavourite(
                                          controller.products[index]);
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
    );
  }

  void _addRemoveFavourite(ProductModel product) {
    var controller = Get.find<ProductsController>();
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
    var controller = Get.find<ProductsController>();
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
