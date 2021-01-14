import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/products_controller.dart';
import 'package:tera/model/category_model.dart';

import '../custom_widgets/custom_appbar.dart';
import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  final controller = Get.find<ProductsController>();

  ProductsScreen({this.categoryModel}) {
    controller.getSubCategories(categoryModel.id);
    controller.selectedSubCategoryIndex = 0;
    controller.subCategories.clear();
    controller.products.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: categoryModel.displayName,
      ),
      body: Body(),
    );
  }
}
