import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_cart_button.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

import 'product_poster.dart';
import 'tabs/info_tab.dart';
import 'tabs/reviews_tab.dart';
import 'tabs/similar_products.dart';

class Body extends StatelessWidget {
  final ProductModel product;
  final controller = Get.find<ProductDetailsController>();

  Body({Key key, this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: kDefaultPadding,
                    end: kDefaultPadding,
                    start: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: ProductPoster(
                        image: product.image,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding),
                        child: CustomText(
                          text: product.name,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${product.price}',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: kDefaultPadding / 2,
                            ),
                            Text(
                              '\$${product.discountPrice}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: size.width / 2.5,
                          // padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Center(
                            child: CustomCartButton(
                              onPressed: () {
                                _addToCart(product);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    _buildTabs(),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              GetBuilder<ProductDetailsController>(
                init: ProductDetailsController(),
                builder: (controller) => Container(
                  color: Colors.white,
                  child: _getTabView(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addToCart(ProductModel productModel) async {
    await Get.find<CartController>().addToCart(productModel);
    CommonMethods()
        .showMessage('cart'.tr, productModel.name + ' ' + 'addedToCart'.tr);
  }

  Widget _getTabView() {
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

  _buildTabs() {
    return Container(
      height: 60,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: Colors.white,
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
                        ? LocalStorage().primaryColor()
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomText(
                    text: 'details'.tr,
                    alignment: AlignmentDirectional.center,
                    color: controller.selectedTab == 0
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
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
                        ? LocalStorage().primaryColor()
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomText(
                    text: 'similarProducts'.tr,
                    alignment: AlignmentDirectional.center,
                    color: controller.selectedTab == 1
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
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
                        ? LocalStorage().primaryColor()
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomText(
                    text: 'reviews'.tr,
                    alignment: AlignmentDirectional.center,
                    color: controller.selectedTab == 2
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
