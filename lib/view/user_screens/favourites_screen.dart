import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/FavouriteController.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/my_products_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/card/products_card.dart';
import 'package:flutter_app/view/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/view/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/view/home/profile_screen.dart';
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
          appBar: AppBar(
            toolbarHeight: 0.0,
          ),
          body: Container(
            color: Constants.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.find<MainController>().setScreen(ProfileScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, top: 20),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20, top: 20),
                        child: CustomText(
                          fontSize: 18,
                          text: 'favorite'.tr,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: controller.loading.value
                        ? LoadingView()
                        : controller.empty.value
                            ? EmptyView(
                                message: 'noFavProducts'.tr,
                                emptyViews: EmptyViews.Box,
                              )
                            : GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                children: List.generate(
                                    controller.products.length,
                                    (index) => ProductsCard(
                                          product: controller.products[index],
                                        ))),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
