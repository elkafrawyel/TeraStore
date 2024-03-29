import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/products_controller.dart';
import 'package:tera/data/models/category_model.dart';

import '../custom_widgets/custom_appbar.dart';
import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  final controller = Get.find<ProductsController>();

  ProductsScreen({this.categoryModel}) {
    controller.categoryModel = categoryModel;
    controller.changeSubCategory(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: categoryModel.displayName,
        actions: [
          GetBuilder<ProductsController>(
            builder: (controller) => controller.isGrid
                ? IconButton(
                    onPressed: () {
                      controller.changeMode();
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.list,
                      size: 30,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      controller.changeMode();
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.view_module,
                      size: 30,
                    ),
                  ),
          )
        ],
      ),
      body: Body(),
    );
  }
}
