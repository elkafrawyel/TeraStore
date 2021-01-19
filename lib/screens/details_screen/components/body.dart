import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/product_details_controller.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/custom_widgets/button/custom_add_to_cart_button.dart';
import 'package:tera/screens/custom_widgets/button/custom_remove_from_cart.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/details_screen/components/product_images_slider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'tabs/info_tab.dart';
import 'tabs/reviews_tab.dart';
import 'tabs/similar_products.dart';

class Body extends StatelessWidget {
  final SingleItem product;
  final controller = Get.find<ProductDetailsController>();

  Body({Key key, this.product});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      ProductImageSlider(
                        singleItemImages: product.images,
                      ),
                      // product discount value
                      PositionedDirectional(
                        end: 10,
                        bottom: 0,
                        child: Visibility(
                          visible: product.discountType == 'percent',
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(22),
                                    topEnd: Radius.circular(0),
                                    bottomStart: Radius.circular(0),
                                    bottomEnd: Radius.circular(10),
                                  ),
                                  color: Colors.red),
                              child: Center(
                                child: CustomText(
                                  text: 'saveMoney'.tr +
                                      ' ${product.discountValue.toString()}%',
                                  fontSize: 18,
                                  alignment: AlignmentDirectional.center,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 0,
                        start: 0,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                _favIcon(),
                                SizedBox(
                                  height: kDefaultPadding / 2,
                                ),
                                !controller.productDetailsResponse.singleItem
                                        .inCart
                                    ? CustomRemoveFromCartButton(
                                        onPressed: () {
                                          _addRemoveCart();
                                        },
                                      )
                                    : CustomAddToCartButton(
                                        onPressed: () {
                                          _addRemoveCart();
                                        },
                                      ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2),
                      child: CustomText(
                        text: product.itemName,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding),
                    child: CustomText(
                      text:
                          '\$${controller.disCountPrice == 0 ? product.itemPriceAfterDis : controller.disCountPrice}',
                      fontSize: 22,
                      alignment: AlignmentDirectional.centerStart,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding),
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '\$${controller.price == 0 ? product.itemPrice : controller.price}',
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                ],
              ),
              _buildProperties(),
              SizedBox(
                height: 20,
              ),
              _buildTabs(),
              SizedBox(
                height: kDefaultPadding,
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
                  // color: Colors.white,
                  child: _getTabView(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _favIcon() {
    return controller.productDetailsResponse.singleItem.isFav
        ? GestureDetector(
            onTap: () {
              _addRemoveFavourite();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              _addRemoveFavourite();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(0.8),
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),
          );
  }

  void _addRemoveFavourite() {
    var controller = Get.find<ProductDetailsController>();
    Get.find<HomeController>().addRemoveFavourites(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          controller.productDetailsResponse.singleItem.isFav =
              !controller.productDetailsResponse.singleItem.isFav;
          controller.update();
          //apply change in filter list
          Get.find<HomeController>().changeFavouriteState(
            product.id.toString(),
          );
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }

  void _addRemoveCart() {
    var controller = Get.find<ProductDetailsController>();
    Get.find<CartController>().addRemoveCart(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          controller.productDetailsResponse.singleItem.inCart =
              !controller.productDetailsResponse.singleItem.inCart;
          controller.update();
          //apply change in filter list
          Get.find<HomeController>().changeInCartState(product.id.toString());
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }

  Widget _getTabView() {
    switch (controller.selectedTab) {
      case 0:
        return InfoTab(
          product: controller.productDetailsResponse.singleItem,
        );
      case 2:
        return controller.loading.value
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : controller.similarProducts.isEmpty
                ? EmptyView(
                    textColor: Colors.white,
                    message: 'noSimilarProducts'.tr,
                  )
                : SimilarProducts(
                    products: controller.similarProducts,
                  );
      case 1:
        return ReviewsTab(
          product: controller.productDetailsResponse.singleItem,
        );
    }
    return InfoTab(
      product: controller.productDetailsResponse.singleItem,
    );
  }

  _buildTabs() {
    return Container(
      width: 1000.0,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ToggleSwitch(
            minWidth: 90.0,
            minHeight: 45.0,
            fontSize: 16.0,
            initialLabelIndex: controller.selectedTab,
            cornerRadius: 20.0,
            activeBgColor: LocalStorage().primaryColor().withOpacity(0.8),
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.white,
            inactiveFgColor: Colors.grey[600],
            labels: [
              'details'.tr,
              'reviews'.tr,
              'similarProducts'.tr,
            ],
            iconSize: 25,
            onToggle: (index) {
              switch (index) {
                case 0:
                  controller.updateSelectedTab(0);
                  break;
                case 1:
                  controller.updateSelectedTab(1);
                  break;
                case 2:
                  controller.updateSelectedTab(2);
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  _buildProperties() {
    List<Widget> columnWidgets = [];
    if (product.properities.isNotEmpty)
      for (ItemProperity properity in product.properities) {
        columnWidgets.add(
          Padding(
            padding: const EdgeInsetsDirectional.only(start: kDefaultPadding),
            child: CustomText(
                text: properity.itemPropertyName,
                fontSize: 18,
                color: Colors.white),
          ),
        );

        var listView = Container(
          height: 70,
          child: GetBuilder<ProductDetailsController>(
            builder: (controller) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: properity.itemPropPlus.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: kDefaultPadding),
                  child: properity.itemPropPlus[index].isSelected
                      ? RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    text:
                                        '${properity.itemPropPlus[index].propertyValue}',
                                    fontSize: 20,
                                    alignment: AlignmentDirectional.center,
                                    color: Colors.white),
                                CustomText(
                                    text:
                                        '+ ${properity.itemPropPlus[index].propertyPrice} EGP',
                                    fontSize: 16,
                                    alignment: AlignmentDirectional.center,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                          onPressed: () {
                            // properity.itemPropPlus[index].propertyPrice
                            // properity.itemPropPlus[index].id
                            controller.updatePropertySelection(
                                properity, properity.itemPropPlus[index]);
                          },
                        )
                      : RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.white)),
                          color: LocalStorage().primaryColor().withOpacity(0.7),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    text:
                                        '${properity.itemPropPlus[index].propertyValue}',
                                    fontSize: 20,
                                    alignment: AlignmentDirectional.center,
                                    color: Colors.white),
                                CustomText(
                                    text:
                                        '+ ${properity.itemPropPlus[index].propertyPrice} EGP',
                                    fontSize: 16,
                                    alignment: AlignmentDirectional.center,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                          onPressed: () {
                            controller.updatePropertySelection(
                                properity, properity.itemPropPlus[index]);
                          },
                        ),
                );
              },
            ),
          ),
        );

        columnWidgets.add(
          SizedBox(
            height: kDefaultPadding / 2,
          ),
        );

        columnWidgets.add(listView);

        columnWidgets.add(
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Divider(
              height: 1,
              color: Colors.white,
            ),
          ),
        );
      }

    return Column(
      children: columnWidgets,
    );
  }
}
