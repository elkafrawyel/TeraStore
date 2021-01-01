import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/menus/custom_language_menu.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/view/user_screens/my_product_screen.dart';
import 'package:flutter_app/view/user_screens/notifications_screen.dart';
import '../user_screens/cards_screen.dart';
import '../user_screens/edit_profile_screen.dart';
import '../user_screens/favourites_screen.dart';
import '../user_screens/order_history_screen.dart';
import '../user_screens/shipping_address_screen.dart';
import 'package:flutter_app/view/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen() {
    Get.find<MainViewModel>().loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return DirectionalWidget(
      pageUi: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<MainViewModel>(
              builder: (controller) => controller.loading.value
                  ? LoadingView()
                  : Container(
                      color: Constants.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 1,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          controller.user != null
                                              ? controller.user.photo
                                              : defaultImageUrl),
                                      radius: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    alignment: AlignmentDirectional.center,
                                    text: controller.user != null
                                        ? controller.user.name
                                        : '',
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomText(
                                    alignment: AlignmentDirectional.center,
                                    text: controller.user != null
                                        ? controller.user.phone
                                        : '',
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomText(
                                    alignment: AlignmentDirectional.center,
                                    text: controller.user != null
                                        ? controller.user.email
                                        : '',
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    _buildRow('editProfile'.tr, Icons.edit, () {
                                      controller.setScreen(EditProfileScreen());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow(
                                        'myProducts'.tr, Icons.shopping_bag,
                                        () {
                                      controller.setScreen(MyProductScreen());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow('favorite'.tr, Icons.favorite,
                                        () {
                                      controller.setScreen(FavouritesScreen());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow('shippingAddresses'.tr,
                                        Icons.location_on, () {
                                      controller.setScreen(ShippingAddresses());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow('orderHistory'.tr, Icons.timer,
                                        () {
                                      controller
                                          .setScreen(OrderHistoryScreen());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow('cards'.tr, Icons.credit_card,
                                        () {
                                      controller.setScreen(CardsScreen());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow('notifications'.tr,
                                        Icons.notifications_active, () {
                                      controller
                                          .setScreen(NotificationsScreen());
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.language,
                                          size: 20,
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
                                            context: context,
                                            action: () {
                                              Get.find<MainViewModel>()
                                                  .logOut();
                                            });
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.logout,
                                              size: 20,
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
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
        ),
      ),
    );
  }

  _buildRow(String text, IconData icon, Function onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: primaryColor,
                ),
                SizedBox(
                  width: 20,
                ),
                CustomText(
                  text: text,
                  fontSize: 16,
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
