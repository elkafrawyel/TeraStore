import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/search_controller.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/details_screen/details_screen.dart';
import 'package:flutter_app/screens/main_screen/components/product_card.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

import 'components/search_box.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'search'.tr,
        elevation: 0,
      ),
      body: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) => Column(
          children: [
            Container(
              color: LocalStorage().primaryColor(),
              child: SearchBox(
                onSubmitted: (value) {
                  controller.search(value);
                },
              ),
            ),
            controller.loading.value
                ? Expanded(child: LoadingView())
                : controller.empty.value
                    ? Expanded(
                        child: ListView(children: [
                          EmptyView(
                            message: 'noFilteredProducts'.tr,
                            textColor: Colors.black,
                          ),
                        ]),
                      )
                    : Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: controller.searchProducts.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  itemIndex: index,
                                  product: controller.searchProducts[index],
                                  press: () {
                                    Get.to(
                                      DetailsScreen(
                                          productId: controller
                                              .searchProducts[index].id),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
