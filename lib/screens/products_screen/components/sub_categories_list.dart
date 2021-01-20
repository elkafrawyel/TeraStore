import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/products_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class SubCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LocalStorage().primaryColor(),
      height: 50,
      child: GetBuilder<ProductsController>(
        init: ProductsController(),
        builder: (controller) => controller.loadingSubCategories.value
            ? LoadingView()
            : controller.emptySubCategories.value
                ? CustomText(
                    text: 'noSubCategories'.tr,
                    alignment: AlignmentDirectional.center,
                    fontSize: fontSizeSmall_16,
                    color: Colors.white,
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categoryModel.subCategories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (controller.selectedSubCategoryIndex != index) {
                          controller.changeSubCategory(index);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(
                          // end: kDefaultPadding / 2,
                          start: kDefaultPadding / 2,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2,
                            vertical: kDefaultPadding / 4),
                        decoration: BoxDecoration(
                          color: index == controller.selectedSubCategoryIndex
                              ? Colors.white.withOpacity(0.4)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.storage,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: kDefaultPadding / 2,
                            ),
                            CustomText(
                              fontSize: fontSizeSmall_16,
                              text: controller.categoryModel
                                  .subCategories[index].displayName,
                              alignment: AlignmentDirectional.center,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
