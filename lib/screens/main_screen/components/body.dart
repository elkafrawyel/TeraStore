import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/home_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'file:///F:/Apps/My%20Flutter%20Apps/E-commerce/lib/screens/main_screen/components/carousel_with_indicator.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/search_box.dart';
import 'package:flutter_app/screens/details_screen/details_screen.dart';
import 'package:get/get.dart';

import 'category_list.dart';
import 'product_card.dart';

class Body extends StatelessWidget {

  Body(){
    Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(
        builder: (controller) => CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SearchBox(onChanged: (value) {}),
                CategoryList(),
                SizedBox(height: kDefaultPadding / 4),
                CarouselWithIndicator(
                  products: controller.products,
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                //take a list of cards
                _buildProductsList(controller.products),
              ),
            ),
          ],
        ),
      ),
    );

    SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {}),
          CategoryList(),
          SizedBox(height: kDefaultPadding / 4),
          GetBuilder<HomeController>(
            builder: (controller) => CarouselWithIndicator(
              products: controller.products,
            ),
          ),
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
                GetBuilder<HomeController>(
                  builder: (controller) => controller.loading.value
                      ? LoadingView()
                      : ListView.builder(
                          // here we use our demo products list
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) => ProductCard(
                            itemIndex: index,
                            product: controller.products[index],
                            press: () {
                              Get.to(DetailsScreen(
                                  productId: controller.products[index].id));
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

  List<Widget> _buildProductsList(List<ProductModel> products) {
    List<Widget> widgets = [];
    products.forEach((element) {
      widgets.add(ProductCard(
        itemIndex: products.indexOf(element),
        product: products[products.indexOf(element)],
        press: () {
          Get.to(
              DetailsScreen(productId: products[products.indexOf(element)].id));
        },
      ));
    });
    return widgets;
  }
}
