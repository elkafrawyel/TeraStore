import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/details_screen/components/tabs/reviews_tab.dart';
import 'package:flutter_app/screens/details_screen/components/tabs/similar_products.dart';
import 'package:get/get.dart';

import 'info_tab.dart';

class TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (controller) => Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: kDefaultPadding, end: kDefaultPadding),
            child: Container(
              height: 60,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.find<MainController>().primaryColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.updateSelectedTab(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: kDefaultPadding / 4,
                            right: kDefaultPadding / 4,
                          ),
                          padding: EdgeInsetsDirectional.only(
                              top: kDefaultPadding / 4,
                              bottom: kDefaultPadding / 4,
                              end: kDefaultPadding,
                              start: kDefaultPadding),
                          decoration: BoxDecoration(
                            color: controller.selectedTab == 0
                                ? Colors.white.withOpacity(0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            text: 'details'.tr,
                            alignment: AlignmentDirectional.center,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateSelectedTab(1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: kDefaultPadding / 4,
                            right: kDefaultPadding / 4,
                          ),
                          padding: EdgeInsetsDirectional.only(
                              top: kDefaultPadding / 4,
                              bottom: kDefaultPadding / 4,
                              end: kDefaultPadding,
                              start: kDefaultPadding),
                          decoration: BoxDecoration(
                            color: controller.selectedTab == 1
                                ? Colors.white.withOpacity(0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            text: 'similarProducts'.tr,
                            alignment: AlignmentDirectional.center,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateSelectedTab(2);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: kDefaultPadding / 4,
                            right: kDefaultPadding / 4,
                          ),
                          padding: EdgeInsetsDirectional.only(
                              top: kDefaultPadding / 4,
                              bottom: kDefaultPadding / 4,
                              end: kDefaultPadding,
                              start: kDefaultPadding),
                          decoration: BoxDecoration(
                            color: controller.selectedTab == 2
                                ? Colors.white.withOpacity(0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            text: 'reviews'.tr,
                            alignment: AlignmentDirectional.center,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          _getTabView(controller),
        ],
      ),
    );
  }

  Widget _getTabView(ProductDetailsController controller) {
    switch (controller.selectedTab) {
      case 0:
        return InfoTab(
          product: controller.productModel,
        );
      case 1:
        return controller.empty.value
            ? EmptyView(
                textColor: Colors.black,
                message: 'noSimilarProducts'.tr,
              )
            : SimilarProducts(
                products: controller.similarProducts,
              );
      case 2:
        return ReviewsTab(
          product: controller.productModel,
        );
    }
    return InfoTab(
      product: controller.productModel,
    );
  }
}
