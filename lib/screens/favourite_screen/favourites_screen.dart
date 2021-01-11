import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/FavouriteController.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/details_screen/details_screen.dart';
import 'package:flutter_app/screens/favourite_screen/components/my_favourite_card.dart';
import 'package:get/get.dart';

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
                      : ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return MyFavouriteCard(
                              itemIndex: index,
                              press: () {
                                Get.to(
                                  DetailsScreen(
                                      productId: controller.products[index].id),
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
