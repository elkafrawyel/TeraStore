import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/search_controller.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/add_product_screen/add_product_screen.dart';
import 'package:tera/screens/cart_screen/cart_screen.dart';
import 'package:tera/screens/custom_widgets/budget_cart_icon.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/home_screen/components/body.dart';
import 'package:tera/screens/search_screen/search_screen.dart';

class Home extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: _buildAppBar(),
        floatingActionButton: _buildFloatingButton(),
        backgroundColor: LocalStorage().primaryColor(),
        body: Body(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                controller.drawerController.toggle();
              }),
          CustomText(
            text: 'home'.tr,
            alignment: AlignmentDirectional.center,
            color: Colors.white,
            fontSize: fontSizeSmall_16,
          ),
        ],
      ),
      backgroundColor: LocalStorage().primaryColor(),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.filter_alt,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            _buildFilterDialog();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () async {
            await Get.to(
              SearchScreen(),
              transition: Transition.upToDown,
              duration: Duration(milliseconds: 500),
            );
            Get.find<SearchController>().searchProducts.clear();
          },
        ),
        BudgetCartIconView(
          press: () {
            Get.to(
              CartScreen(),
              transition: Transition.upToDown,
              duration: Duration(milliseconds: 500),
            );
          },
        ),
      ],
    );
  }

  _buildFloatingButton() {
    return FloatingActionButton(
      backgroundColor: LocalStorage().primaryColor(),
      onPressed: () async {
        Get.to(
          AddProductScreen(),
          transition: Transition.downToUp,
          duration: Duration(milliseconds: 500),
        );
      },
      child: Icon(
        Icons.add,
        size: 30,
      ),
    );
  }

  _buildFilterDialog() {
    showDialog(
        context: Get.context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: GetBuilder<HomeController>(
                builder: (controller) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'sortBy'.tr,
                      alignment: AlignmentDirectional.center,
                      fontSize: fontSizeSmall_16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: kDefaultPadding * 2, start: kDefaultPadding * 2),
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        //Latest Radio
                        Row(
                          children: [
                            Radio<ProductFilters>(
                              value: ProductFilters.Latest,
                              groupValue: controller.filter,
                              onChanged: (value) {
                                controller.filter = value;
                                controller.update();
                              },
                            ),
                            Text(ProductFilters.Latest.text,
                                style: TextStyle(fontSize: fontSizeSmall_16)),
                          ],
                        ),

                        //High Price Radio
                        Row(
                          children: [
                            Radio(
                              value: ProductFilters.HighPrice,
                              groupValue: controller.filter,
                              onChanged: (value) {
                                controller.filter = value;
                                controller.update();
                              },
                            ),
                            Text(ProductFilters.HighPrice.text,
                                style: TextStyle(fontSize: fontSizeSmall_16)),
                          ],
                        ),

                        //Low Price Radio
                        Row(
                          children: [
                            Radio(
                              value: ProductFilters.LowPrice,
                              groupValue: controller.filter,
                              onChanged: (value) {
                                controller.filter = value;
                                controller.update();
                              },
                            ),
                            Text(ProductFilters.LowPrice.text,
                                style: TextStyle(fontSize: fontSizeSmall_16)),
                          ],
                        ),

                        //High Rate Radio
                        Row(
                          children: [
                            Radio(
                              value: ProductFilters.HighRate,
                              groupValue: controller.filter,
                              onChanged: (value) {
                                controller.filter = value;
                                controller.update();
                              },
                            ),
                            Text(ProductFilters.HighRate.text,
                                style: TextStyle(fontSize: fontSizeSmall_16)),
                          ],
                        ),
                        //Price Radio
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: ProductFilters.Range,
                                  groupValue: controller.filter,
                                  onChanged: (value) {
                                    controller.filter = value;
                                    controller.update();
                                  },
                                ),
                                Text(ProductFilters.Range.text,
                                    style:
                                        TextStyle(fontSize: fontSizeSmall_16)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'from'.tr +
                                            ' : ${controller.lowerValue.toString()}',
                                        fontSize: fontSizeSmall_16 - 2,
                                      ),
                                      CustomText(
                                        text: 'to'.tr +
                                            ' : ${controller.upperValue.toString()}',
                                        fontSize: fontSizeSmall_16 - 2,
                                      )
                                    ],
                                  ),
                                  FlutterSlider(
                                    values: [
                                      controller.lowerValue,
                                      controller.upperValue
                                    ],
                                    disabled: controller.filter !=
                                        ProductFilters.Range,
                                    trackBar: FlutterSliderTrackBar(
                                      inactiveTrackBar: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black12,
                                        border: Border.all(
                                            width: 3, color: Colors.blue),
                                      ),
                                      activeTrackBar: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.blue.withOpacity(0.5)),
                                    ),
                                    max: 20000,
                                    min: 0,
                                    selectByTap: true,
                                    rtl: LocalStorage().isArabicLanguage(),
                                    rangeSlider: true,
                                    tooltip: FlutterSliderTooltip(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          color: LocalStorage().primaryColor()),
                                    ),
                                    handlerAnimation:
                                        FlutterSliderHandlerAnimation(
                                            curve: Curves.elasticOut,
                                            duration:
                                                Duration(milliseconds: 700),
                                            scale: 1.4),
                                    onDragging:
                                        (handlerIndex, lowerValue, upperValue) {
                                      controller.lowerValue = lowerValue;
                                      controller.upperValue = upperValue;
                                      controller.update();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        controller.filterProducts();
                        CommonMethods().showSnackBar(
                            '${'sortBy'.tr} ${controller.filter.text}');
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: kDefaultPadding, bottom: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: LocalStorage().primaryColor(),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: Text(
                          "ok".tr,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
