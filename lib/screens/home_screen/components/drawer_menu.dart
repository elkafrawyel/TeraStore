import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/favourite_screen/favourites_screen.dart';
import 'package:tera/screens/orders_screen/orders_screen.dart';
import 'package:tera/screens/profile/profile_screen.dart';

import '../../about_screen.dart';
import '../../notifications_screen/notifications_screen.dart';
import '../../settings_screen.dart';
import '../../shipping_address_screen.dart';

class DrawerMenu extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: LocalStorage().primaryColor(),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsetsDirectional.only(bottom: kDefaultPadding * 2),
            child: Column(
              children: <Widget>[
                //Header
                GetBuilder<MainController>(
                  builder: (controller) => controller.user == null
                      ? Container(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsetsDirectional.only(
                              start: kDefaultPadding),
                          child: GetBuilder<MainController>(
                            builder: (controller) => GestureDetector(
                              onTap: () {
                                homeController.drawerController.close();
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          controller.user.photo,
                                        ),
                                        radius: 60,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: controller.user.name,
                                    fontSize: fontSizeSmall_16,
                                    alignment: AlignmentDirectional.centerStart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: kDefaultPadding / 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),

                _buildRow('favorite'.tr, Icons.favorite, () {
                  Get.to(
                    FavouritesScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
                }),

                _buildRow('myOrders'.tr, Icons.timer, () async {
                  Get.to(
                    OrdersScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
                }),

                _buildRow('shippingAddresses'.tr, Icons.location_on, () {
                  Get.to(
                    ShippingAddresses(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
                }),

                _buildRow('notifications'.tr, Icons.notifications_active, () {
                  Get.to(
                    NotificationsScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
                }),
                _buildRow('settings'.tr, Icons.settings, () {
                  Get.to(
                    SettingsScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: kDefaultPadding,
                            start: kDefaultPadding,
                            end: kDefaultPadding),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                _buildRow('about'.tr, Icons.info_outlined, () {
                  Get.to(
                    AboutScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
                }),

                _buildRow('privacy'.tr, Icons.mark_chat_read_outlined, () {}),

                _buildRow('howToUse'.tr, Icons.question_answer, () {}),

                _buildRow('contactUs'.tr, Icons.contact_support, () {}),

                _buildRow('rateApp'.tr, Icons.star_border, () {}),

                SizedBox(
                  height: kDefaultPadding,
                ),
                Container(
                  height: 50,
                  child: RaisedButton.icon(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: CustomText(
                        text: 'logOut'.tr,
                        fontSize: fontSizeSmall_16,
                        alignment: AlignmentDirectional.center,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white, width: 1),
                      ),
                      color: LocalStorage().primaryColor().withOpacity(0.6),
                      elevation: 1,
                      disabledTextColor: Colors.black,
                      disabledColor: Colors.grey,
                      textColor: Colors.white,
                      onPressed: () {
                        CommonMethods().customExitAlert(
                            context: Get.context,
                            action: () {
                              Get.find<MainController>().logOut();
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildRow(String text, IconData icon, Function onPressed) {
    return GestureDetector(
      onTap: () {
        homeController.drawerController.close();
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            top: kDefaultPadding,
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
                  color: Colors.white,
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                CustomText(
                  text: text,
                  color: Colors.white,
                  fontSize: fontSizeSmall_16 - 2,
                ),
              ],
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
