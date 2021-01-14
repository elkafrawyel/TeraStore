import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/model/category_model.dart';
import 'package:tera/model/sub_category_model.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class CategoriesDropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Center(
              child: DropdownButton<CategoryModel>(
                iconDisabledColor: Colors.grey,
                isExpanded: true,
                iconSize: 40,
                onChanged: (CategoryModel categoryModel) {
                  controller.setCategoryModel(categoryModel);
                },
                value: controller.categoryModel,
                hint: Center(
                  child: CustomText(
                    text: 'category'.tr,
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
                items: controller.categories
                    .map<DropdownMenuItem<CategoryModel>>(
                      (model) => DropdownMenuItem<CategoryModel>(
                        value: model,
                        child: Center(
                          child: Text(
                            model.displayName,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Center(
              child: DropdownButton<SubCategoryModel>(
                iconDisabledColor: Colors.grey,
                isExpanded: true,
                iconSize: 40,
                onChanged: (SubCategoryModel subCategoryModel) {
                  controller.setSubCategoryModel(subCategoryModel);
                },
                value: controller.subCategoryModel,
                hint: Center(
                  child: CustomText(
                    text: 'subCategory'.tr,
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
                items: controller.subCategories
                    .map<DropdownMenuItem<SubCategoryModel>>(
                      (model) => DropdownMenuItem<SubCategoryModel>(
                        value: model,
                        child: Center(
                          child: Text(
                            model.displayName,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
