import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/products_view_model.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/sub_category_model.dart';
import 'package:flutter_app/view/custom_widgets/card/products_card.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:get/get.dart';
import 'custom_widgets/custom_appbar.dart';
import 'custom_widgets/data_state_views/empty_view.dart';
import 'custom_widgets/data_state_views/loading_view.dart';

class ProductsScreen extends StatelessWidget {
  final SubCategoryModel subCategoryModel;
  final ProductsViewModel _productsViewModel = Get.put(ProductsViewModel());

  ProductsScreen({this.subCategoryModel}) {
    _productsViewModel.getProducts(subCategoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsViewModel>(
      init: _productsViewModel,
      builder: (controller) =>DirectionalWidget(
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
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    children: List.generate(
                        controller.products.length,
                            (index) => ProductsCard(
                          product: controller.products[index],
                        ))),
              ),
            )),
      )
    );
  }
}
