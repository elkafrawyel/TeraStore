import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/model/product_model.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

import 'carousel_with_indicator.dart';
import 'category_list.dart';
import 'product_card.dart';

class Body extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => controller.loading.value
            ? LoadingView()
            : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: kDefaultPadding),
                      CarouselWithIndicator(
                        products: controller.sliderProducts,
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      CategoryList(),
                    ]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      //take a list of cards
                      controller.empty.value
                          ? [
                              EmptyView(
                                message: 'noFilteredProducts'.tr,
                                textColor: Colors.white,
                              )
                            ]
                          : _buildProductsList(controller.products),
                    ),
                  ),
                ],
              ),
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
    widgets.add(SizedBox(
      height: 80,
    ));
    return widgets;
  }
}
