import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/sub_category_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/directional_widget.dart';
import 'package:flutter_app/screens/products_screen.dart';
import 'package:get/get.dart';

import 'custom_widgets/text/custom_text.dart';

class SubCategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  final SubCategoryController _subCategoryController = Get.find();

  SubCategoryScreen({this.categoryModel}) {
    _subCategoryController.getSubCategories(categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
        init: _subCategoryController,
        builder: (controller) => DirectionalWidget(
              pageUi: Scaffold(
                appBar: CustomAppBar(
                  text: categoryModel.displayName,
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
                                      controller.subCategories.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              Get.to(ProductsScreen(
                                                subCategoryModel: controller
                                                    .subCategories[index],
                                              ));
                                            },
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 140,
                                                    height: 140,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        height: 150,
                                                        placeholder:
                                                            placeholder,
                                                        image: controller
                                                            .subCategories[
                                                                index]
                                                            .image,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomText(
                                                      text: controller
                                                          .subCategories[
                                                              index]
                                                          .displayName,
                                                      fontSize: 16,
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))),
                            ),
                          ),
              ),
            ));
  }
}
