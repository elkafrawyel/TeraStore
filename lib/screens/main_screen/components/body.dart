import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/explore_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/search_box.dart';
import 'package:flutter_app/screens/product_details_screen.dart';
import 'package:get/get.dart';

import 'category_list.dart';
import 'product_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {}),
          CategoryList(),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                GetBuilder<ExploreController>(
                  builder: (controller) => controller.loading.value
                      ? LoadingView()
                      : ListView.builder(
                          // here we use our demo products list
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) => ProductCard(
                            itemIndex: index,
                            product: controller.products[index],
                            press: () {
                              Get.to(ProductDetailsScreen(
                                  controller.products[index].id));
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
