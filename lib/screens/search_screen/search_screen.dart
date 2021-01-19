import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/search_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/error_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/product_card.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

import 'components/search_box.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'search'.tr,
        elevation: 0,
      ),
      backgroundColor: LocalStorage().primaryColor(),
      body: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) => Column(
          children: [
            Container(
              color: LocalStorage().primaryColor(),
              child: SearchBox(
                onSubmitted: (value) {
                  controller.search(value);
                },
              ),
            ),
            controller.loading.value
                ? Expanded(child: LoadingView())
                : controller.empty.value
                    ? controller.error.value
                        ? ErrorView()
                        : Expanded(
                            child: ListView(children: [
                              EmptyView(
                                message: 'noFilteredProducts'.tr,
                                textColor: Colors.white,
                              ),
                            ]),
                          )
                    : Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: controller.searchProducts.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  itemIndex: index,
                                  product: controller.searchProducts[index],
                                  press: () {
                                    Get.to(
                                      DetailsScreen(
                                          productId: controller
                                              .searchProducts[index].id
                                              .toString()),
                                    );
                                  },
                                  onCartClicked: () {
                                    _addRemoveCart(
                                        controller.searchProducts[index]);
                                  },
                                  onFavouriteClicked: () {
                                    _addRemoveFavourite(
                                        controller.searchProducts[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  void _addRemoveFavourite(ProductModel product) {
    var controller = Get.find<SearchController>();
    Get.find<HomeController>().addRemoveFavourites(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct = controller
              .searchProducts[controller.searchProducts.indexOf(product)];
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
    var controller = Get.find<SearchController>();
    Get.find<CartController>().addRemoveCart(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct = controller
              .searchProducts[controller.searchProducts.indexOf(product)];
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
