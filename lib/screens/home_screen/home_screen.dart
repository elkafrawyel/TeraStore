import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/add_product_screen.dart';
import 'package:tera/screens/cart_screen/cart_screen.dart';
import 'package:tera/screens/custom_widgets/budget_cart_icon.dart';
import 'package:tera/screens/custom_widgets/menus/custom_language_menu.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/favourite_screen/favourites_screen.dart';
import 'package:tera/screens/notifications_screen.dart';
import 'package:tera/screens/order_history_screen.dart';
import 'package:tera/screens/profile/profile_screen.dart';
import 'package:tera/screens/search_screen/search_screen.dart';
import 'package:tera/screens/settings_screen.dart';
import 'package:tera/screens/shipping_address_screen.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomeScreen() {
    Get.find<MainController>().loadUserData();
    Get.find<CartController>().getCartItems(showLoading: true);
    controller.getSliderProducts();
    controller.filterProducts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: _buildAppBar(),
          drawer: _buildDrawer(),
          floatingActionButton: _buildFloatingButton(),
          backgroundColor: LocalStorage().primaryColor(),
          body: Body(),
        ),
        onWillPop: _willPopCallback);
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        'home'.tr,
        style: TextStyle(color: Colors.white, fontSize: 16),
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
          onPressed: () {
            Get.to(
              SearchScreen(),
              transition: Transition.upToDown,
              duration: Duration(milliseconds: 500),
            );
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

  _buildDrawer() {
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 40),
          child: Column(
            children: <Widget>[
              //Header
              GetBuilder<MainController>(
                builder: (controller) => controller.user == null
                    ? Container(
                        height: 200,
                        color: LocalStorage().primaryColor(),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        color: LocalStorage().primaryColor(),
                        child: GetBuilder<MainController>(
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.to(
                                ProfileScreen(),
                                transition: Transition.zoom,
                                duration: Duration(milliseconds: 500),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: kDefaultPadding * 2,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    controller.user.photo,
                                  ),
                                  radius: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: controller.user.name,
                                  fontSize: 18,
                                  alignment: AlignmentDirectional.center,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildRow('favorite'.tr, Icons.favorite, () {
                Get.to(
                  FavouritesScreen(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 500),
                );
              }),
              SizedBox(
                height: 20,
              ),

              _buildRow('shippingAddresses'.tr, Icons.location_on, () {
                Get.to(
                  ShippingAddresses(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 500),
                );
              }),
              SizedBox(
                height: 20,
              ),
              _buildRow('orderHistory'.tr, Icons.timer, () {
                Get.to(
                  OrderHistoryScreen(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 500),
                );
              }),
              SizedBox(
                height: 20,
              ),
              _buildRow('notifications'.tr, Icons.notifications_active, () {
                Get.to(
                  NotificationsScreen(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 500),
                );
              }),
              SizedBox(
                height: 20,
              ),
              _buildRow('settings'.tr, Icons.settings, () {
                Get.to(
                  SettingsScreen(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 500),
                );
              }),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildRow('about'.tr, Icons.info_outlined, () {}),
              SizedBox(
                height: 20,
              ),
              _buildRow('privacy'.tr, Icons.mark_chat_read_outlined, () {}),
              SizedBox(
                height: 20,
              ),
              _buildRow('howToUse'.tr, Icons.question_answer, () {}),
              SizedBox(
                height: 20,
              ),
              _buildRow('contactUs'.tr, Icons.contact_support, () {}),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  GetBuilder<MainController>(
                    builder: (controller) => Icon(
                      Icons.language,
                      size: 25,
                      color: LocalStorage().primaryColor(),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomLanguageMenu(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  CommonMethods().customExitAlert(
                      context: Get.context,
                      action: () {
                        Get.find<MainController>().logOut();
                      });
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      GetBuilder<MainController>(
                        builder: (controller) => Icon(
                          Icons.logout,
                          size: 25,
                          color: LocalStorage().primaryColor(),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomText(
                        text: 'logOut'.tr,
                        fontSize: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(String text, IconData icon, Function onPressed) {
    return GestureDetector(
      onTap: () {
        Get.back();
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            top: kDefaultPadding / 2,
            start: kDefaultPadding / 2,
            end: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 25,
                  color: LocalStorage().primaryColor(),
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: text,
                  fontSize: 16,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: LocalStorage().primaryColor(),
            ),
          ],
        ),
      ),
    );
  }

  _buildFloatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () async {
        await Get.to(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
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
                                style: TextStyle(fontSize: 16)),
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
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        //High Rate Radio
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
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),

                        // //Low Rate Radio
                        // Row(
                        //   children: [
                        //     Radio(
                        //       value: ProductFilters.LowRate,
                        //       groupValue: controller.filter,
                        //       onChanged: (value) {
                        //         controller.filter = value;
                        //         controller.update();
                        //       },
                        //     ),
                        //     Text(ProductFilters.LowRate.text,
                        //         style: TextStyle(fontSize: 16)),
                        //   ],
                        // ),
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
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
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

  Future<bool> _willPopCallback() async {
    CommonMethods().customAlert(
        title: 'close'.tr,
        message: 'closeMessage'.tr,
        action: () {
          SystemNavigator.pop(animated: true);
        });
    return Future.value(true);
  }
}
