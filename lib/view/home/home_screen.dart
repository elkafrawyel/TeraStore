import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/view/search_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DirectionalWidget(
      pageUi: GetBuilder<MainViewModel>(
        builder: (controller) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomText(
                        text: 'home'.tr,
                        color: primaryColor,
                        fontSize: 18,
                        alignment: AlignmentDirectional.center,
                      ),
                    ),
                    icon: Icon(Icons.home),
                    label: ''),
                BottomNavigationBarItem(
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomText(
                        text: 'cart'.tr,
                        color: primaryColor,
                        fontSize: 18,
                        alignment: AlignmentDirectional.center,
                      ),
                    ),
                    icon: Icon(Icons.shopping_cart),
                    label: ''),
                BottomNavigationBarItem(
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomText(
                        text: 'profile'.tr,
                        color: primaryColor,
                        fontSize: 18,
                        alignment: AlignmentDirectional.center,
                      ),
                    ),
                    icon: Icon(Icons.perm_identity_outlined),
                    label: ''),
              ],
              currentIndex: controller.navigatorSelectedIndex,
              onTap: (index) {
                controller.changeSelectedIndex(index);
              },
              elevation: 0,
              selectedItemColor: primaryColor,
              backgroundColor: Colors.grey.shade50,
            ),
            // bottomNavigationBar: BottomBarWithSheet(
            //   disableMainActionButton: true,
            //   selectedIndex: controller.navigatorSelectedIndex,
            //   sheetChild: _searchSheet(),
            //   bottomBarTheme: BottomBarTheme(
            //     mainButtonPosition: MainButtonPosition.Left,
            //     selectedItemBackgroundColor: primaryColor,
            //     backgroundColor: Colors.white,
            //     selectedItemLabelColor: primaryColor,
            //     selectedItemIconColor: Colors.white,
            //     itemLabelColor: Colors.black38,
            //     itemIconColor: Colors.black38,
            //   ),
            //   mainActionButtonTheme: MainActionButtonTheme(
            //     size: 60,
            //     color: primaryColor,
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.white,
            //       size: 30,
            //     ),
            //   ),
            //   onSelectItem: (index) => controller.changeSelectedIndex(index),
            //   items: [
            //     BottomBarWithSheetItem(
            //       icon: Icons.home,
            //       label: 'home'.tr,
            //     ),
            //     BottomBarWithSheetItem(
            //       icon: Icons.shopping_cart,
            //       label: 'cart'.tr,
            //     ),
            //     BottomBarWithSheetItem(
            //       icon: Icons.account_box,
            //       label: 'profile'.tr,
            //     ),
            //     // BottomBarWithSheetItem(icon: Icons.favorite),
            //   ],
            // ),
            body: controller.currentScreen),
      ),
    );
  }

  Widget _searchTextFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor.shade500),
        child: TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'search'.tr,
            hintStyle: TextStyle(color: Colors.white, fontSize: 20),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _searchSheet() {
    return Column(
      children: [
        _searchTextFormField(),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(Get.context).size.width * 0.5,
          child: CustomButton(
            text: 'Apply Filter',
            onPressed: () {
              Get.to(SearchScreen());
            },
            colorText: Colors.white,
            colorBackground: primaryColor,
          ),
        )
      ],
    );
  }
}
