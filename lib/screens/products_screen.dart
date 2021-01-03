import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/products_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/sub_category_model.dart';
import 'package:flutter_app/screens/custom_widgets/card/products_card.dart';
import 'package:flutter_app/screens/custom_widgets/directional_widget.dart';
import 'package:flutter_app/screens/product_details_screen.dart';
import 'package:get/get.dart';
import 'custom_widgets/custom_appbar.dart';
import 'custom_widgets/data_state_views/empty_view.dart';
import 'custom_widgets/data_state_views/loading_view.dart';
import 'main_screen/components/product_card.dart';

class ProductsScreen extends StatelessWidget {
  final SubCategoryModel subCategoryModel;

  ProductsScreen({this.subCategoryModel}) {
    Get.put(ProductsController()).getProducts(subCategoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
        builder: (controller) => DirectionalWidget(
              pageUi: Scaffold(
                  appBar: CustomAppBar(
                    text: subCategoryModel.displayName,
                  ),
                  body: controller.loading.value
                      ? LoadingView()
                      : controller.empty.value
                          ? EmptyView()
                          : Container(
                              color: Constants.backgroundColor,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: controller.products.length,
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                        itemIndex: index,
                                        product: controller.products[index],
                                        press: () {
                                          Get.to(
                                            ProductDetailsScreen(
                                                controller.products[index].id),
                                          );
                                        },
                                      );
                                    },
                                  )),
                            )),
            ));
  }
}
