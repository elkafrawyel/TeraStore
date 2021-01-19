import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/error_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/product_card_grid.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

import 'carousel_with_indicator.dart';
import 'category_list.dart';

class Body extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => controller.loadingCategories.value
            ? LoadingView(
                backgroundColor: LocalStorage().primaryColor(),
              )
            : controller.error.value
                ? ErrorView()
                : CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(height: kDefaultPadding),
                          controller.emptySliders.value
                              ? EmptyView(
                                  message: 'Empty Sliders',
                                  textColor: Colors.white,
                                  emptyViews: EmptyViews.Magnifier,
                                )
                              : CarouselWithIndicator(
                                  products: controller.sliderProducts,
                                ),
                          SizedBox(height: kDefaultPadding / 2),
                          controller.emptyCategories.value
                              ? EmptyView(
                                  message: 'Empty Sliders',
                                  textColor: Colors.white,
                                  emptyViews: EmptyViews.Magnifier,
                                )
                              : CategoryList(),
                        ]),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.55),
                        delegate: SliverChildListDelegate(
                          //take a list of cards
                          controller.loading.value
                              ? [
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                ]
                              : controller.empty.value
                                  ? [
                                      EmptyView(
                                        message: 'noFilteredProducts'.tr,
                                        textColor: Colors.white,
                                      )
                                    ]
                                  : _buildProductsList(
                                      controller.filteredProducts),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 60,
                        )
                      ]))
                    ],
                  ),
      ),
    );
  }

  List<Widget> _buildProductsList(List<ProductModel> products) {
    List<Widget> widgets = [];

    products.forEach((element) {
      widgets.add(ProductCardGrid(
        itemIndex: products.indexOf(element),
        product: products[products.indexOf(element)],
        press: () {
          Get.to(DetailsScreen(
              productId: products[products.indexOf(element)].id.toString()));
        },
        onFavouriteClicked: () {
          _addRemoveFavourite(products[products.indexOf(element)]);
        },
        onCartClicked: () {
          _addRemoveCart(products[products.indexOf(element)]);
        },
      ));
    });
    return widgets;
  }

  void _addRemoveFavourite(ProductModel product) {
    var controller = Get.find<HomeController>();
    controller.addRemoveFavourites(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct = controller
              .filteredProducts[controller.filteredProducts.indexOf(product)];
          myProduct.isFav = !myProduct.isFav;
          controller.update();
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }

  void _addRemoveCart(ProductModel product) {
    var controller = Get.find<HomeController>();
    Get.find<CartController>().addRemoveCart(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct = controller
              .filteredProducts[controller.filteredProducts.indexOf(product)];
          myProduct.inCart = !myProduct.inCart;
          controller.update();
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }
}
