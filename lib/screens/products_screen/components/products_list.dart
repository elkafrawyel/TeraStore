import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/products_controller.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/error_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/details_screen/details_screen.dart';
import 'package:tera/screens/products_screen/components/products_in_category_card.dart';

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
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return ProductsInCategoryCard(
                              itemIndex: index,
                              product: controller.products[index],
                              press: () {
                                Get.to(
                                  DetailsScreen(
                                      productId: controller.products[index].id
                                          .toString()),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
    );
  }
}
