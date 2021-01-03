import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/budget_cart_icon.dart';
import 'package:flutter_app/screens/custom_widgets/menus/custom_language_menu.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'file:///F:/Apps/My%20Flutter%20Apps/E-commerce/lib/screens/cart_screen.dart';
import 'package:flutter_app/screens/profile/profile_screen.dart';
import 'package:flutter_app/screens/settings_screen.dart';
import 'package:flutter_app/screens/user_screens/cards_screen.dart';
import 'package:flutter_app/screens/user_screens/favourites_screen.dart';
import 'package:flutter_app/screens/user_screens/notifications_screen.dart';
import 'package:flutter_app/screens/user_screens/order_history_screen.dart';
import 'package:flutter_app/screens/user_screens/shipping_address_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'components/body.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      backgroundColor: primaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('home'.tr),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.filter_alt,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            //show filter dialog
          },
        ),
        IconButton(
          icon: SvgPicture.asset("src/images/notification.svg"),
          onPressed: () {
            Get.to(NotificationsScreen());
          },
        ),
        BudgetCartIconView(press: (){
          Get.to(CartScreen());
        },),
      ],
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //Header
          Container(
            color: primaryColor,
            child: GetBuilder<MainController>(
              builder: (controller) => GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(ProfileScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
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
                    CustomText(
                      text: controller.user.email,
                      fontSize: 16,
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
          SizedBox(
            height: 20,
          ),
          _buildRow('favorite'.tr, Icons.favorite, () {
            Get.to(FavouritesScreen());
          }),
          SizedBox(
            height: 20,
          ),
          _buildRow('shippingAddresses'.tr, Icons.location_on, () {
            Get.to(ShippingAddresses());
          }),
          SizedBox(
            height: 20,
          ),
          _buildRow('orderHistory'.tr, Icons.timer, () {
            Get.to(OrderHistoryScreen());
          }),
          SizedBox(
            height: 20,
          ),
          _buildRow('cards'.tr, Icons.credit_card, () {
            Get.to(CardsScreen());
          }),
          SizedBox(
            height: 20,
          ),
          _buildRow('about'.tr, Icons.read_more, () {
            Get.to(CardsScreen());
          }),
          SizedBox(
            height: 20,
          ),
          _buildRow('privacy'.tr, Icons.mark_chat_read_outlined, () {
            Get.to(CardsScreen());
          }),
          SizedBox(
            height: 20,
          ),
          _buildRow('settings'.tr, Icons.settings, () {
            Get.to(SettingsScreen());
          }),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.language,
                size: 25,
                color: primaryColor,
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
                    width: 20,
                  ),
                  Icon(
                    Icons.logout,
                    size: 25,
                    color: primaryColor,
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
          )
        ],
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
            start: kDefaultPadding,
            end: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 25,
                  color: primaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: text,
                  fontSize: 18,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
