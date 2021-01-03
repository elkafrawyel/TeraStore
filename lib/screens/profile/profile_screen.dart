import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/my_products_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/custom_widgets/directional_widget.dart';
import 'package:flutter_app/screens/main_screen/components/product_card.dart';
import 'package:flutter_app/screens/user_screens/edit_profile_screen.dart';
import 'package:get/get.dart';
import '../product_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen() {
    Get.put(MyProductsController()).getMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return DirectionalWidget(
      pageUi: Scaffold(
        appBar: CustomAppBar(
          text: 'profile'.tr,
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: GestureDetector(
                onTap: (){
                  Get.to(EditProfileScreen());
                },
                child: Icon(
                  Icons.edit,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              GetBuilder<MainController>(
                builder: (controller) => controller.loading.value
                    ? LoadingView()
                    : Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: primaryColor,
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              child: Row(
                                children: [
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
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        alignment: AlignmentDirectional.center,
                                        text: controller.user != null
                                            ? controller.user.name
                                            : '',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        alignment: AlignmentDirectional.center,
                                        text: controller.user != null
                                            ? controller.user.phone == null
                                                ? 'noPhone'.tr
                                                : controller.user.phone
                                            : '',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        alignment: AlignmentDirectional.center,
                                        text: controller.user != null
                                            ? controller.user.email
                                            : '',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: 'myProducts'.tr,
                  fontSize: 20,
                  alignment: AlignmentDirectional.center,
                ),
              ),
              _myProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myProducts() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          // Our background
          Container(
            margin: EdgeInsets.only(top: 70),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          GetBuilder<MyProductsController>(
            builder: (controller) => controller.loading.value
                ? LoadingView()
                : ListView.builder(
                    // here we use our demo products list
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) => ProductCard(
                      itemIndex: index,
                      product: controller.products[index],
                      showActions: true,
                      press: () {
                        Get.to(ProductDetailsScreen(
                            controller.products[index].id));
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
