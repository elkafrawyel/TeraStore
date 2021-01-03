import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/FavouriteController.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/my_products_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/card/products_card.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/details_screen/details_screen.dart';
import 'package:flutter_app/screens/main_screen/components/product_card.dart';
import 'package:flutter_app/screens/product_details_screen.dart';
import 'file:///F:/Apps/My%20Flutter%20Apps/E-commerce/lib/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget {
  final FavouriteController _favouriteController =
      Get.put(FavouriteController());

  FavouritesScreen() {
    _favouriteController.getMyFavouriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
      init: _favouriteController,
      builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            text: 'favorite'.tr,
          ),
          body: Container(
            color: Constants.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.loading.value
                  ? LoadingView()
                  : controller.empty.value
                      ? EmptyView(
                          message: 'noFavProducts'.tr,
                          emptyViews: EmptyViews.Box,
                        )
                      : ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              itemIndex: index,
                              press: () {
                                Get.to(
                                  DetailsScreen(productId:
                                      controller.products[index].id),
                                );
                              },
                              product: controller.products[index],
                            );
                          }),
            ),
          )),
    );
  }
}
