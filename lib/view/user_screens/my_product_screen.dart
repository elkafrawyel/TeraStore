import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/core/view_model/my_products_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/view/home/profile_screen.dart';
import 'package:get/get.dart';

import '../custom_widgets/card/products_card.dart';
import '../custom_widgets/custom_appbar.dart';
import '../custom_widgets/data_state_views/empty_view.dart';
import '../custom_widgets/data_state_views/loading_view.dart';

class MyProductScreen extends StatelessWidget {
  final MyProductsController _myProductsController =
      Get.put(MyProductsController());

  MyProductScreen() {
    _myProductsController.getMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProductsController>(
      init: _myProductsController,
      builder: (controller) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
          ),
          body: controller.loading.value
              ? LoadingView()
              : controller.empty.value
                  ? EmptyView(
                      message: 'noProducts'.tr,
                      emptyViews: EmptyViews.Box,
                    )
                  : Container(
                      color: Constants.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.find<MainViewModel>()
                                        .setScreen(ProfileScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 20, top: 20),
                                    child: Icon(Icons.arrow_back),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20, top: 20),
                                  child: CustomText(
                                    fontSize: 18,
                                    text: 'myProducts'.tr,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  children: List.generate(
                                      controller.products.length,
                                      (index) => ProductsCard(
                                            product: controller.products[index],
                                          ))),
                            ),
                          ],
                        ),
                      ),
                    )),
    );
  }
}
