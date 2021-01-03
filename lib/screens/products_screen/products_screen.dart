import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/products_controller.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/screens/products_screen/components/body.dart';
import 'package:get/get.dart';
import '../custom_widgets/custom_appbar.dart';

class ProductsScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  ProductsScreen({this.categoryModel}) {
    var controller =Get.put(ProductsController());
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
