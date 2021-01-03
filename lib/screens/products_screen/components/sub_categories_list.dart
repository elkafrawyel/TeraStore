import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/products_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';

class SubCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.find<MainController>().primaryColor,
      height: 40,
      child: GetBuilder<ProductsController>(
        builder: (controller) => controller.loadingSubCategories.value
            ? LoadingView()
            : controller.emptySubCategories.value
                ? CustomText(
                    text: 'noSubCategories'.tr,
                    alignment: AlignmentDirectional.center,
                    fontSize: 18,
                    color: Colors.white,
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.subCategories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (controller.selectedSubCategoryIndex != index) {
                          controller.selectedSubCategoryIndex = index;
                          //load products
                          Get.find<ProductsController>().getProducts();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(
                          end: index == controller.subCategories.length - 1
                              ? kDefaultPadding
                              : 0,
                          start: kDefaultPadding,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding / 4),
                        decoration: BoxDecoration(
                          color: index == controller.selectedSubCategoryIndex
                              ? Colors.white.withOpacity(0.4)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CustomText(
                          text: controller.subCategories[index].displayName,
                          alignment: AlignmentDirectional.center,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
