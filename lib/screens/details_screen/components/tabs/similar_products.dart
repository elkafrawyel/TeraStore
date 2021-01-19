import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/product_details_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/custom_widgets/product_card.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

class SimilarProducts extends StatelessWidget {
  final List<ProductModel> products;

  SimilarProducts({this.products});

  @override
  Widget build(BuildContext context) {
    return _productsList();
  }

  _productsList() {
    return Column(
      children: _similarProducts(),
    );
  }

  List<Widget> _similarProducts() {
    List<Widget> widgets = [];
    products.forEach((element) {
      widgets.add(ProductCard(
        itemIndex: products.indexOf(element),
        product: products[products.indexOf(element)],
        press: () {
          Get.to(
            DetailsScreen(
                productId: products[products.indexOf(element)].id.toString()),
          );
        },
        onCartClicked: () {
          _addRemoveCart(products[products.indexOf(element)]);
        },
        onFavouriteClicked: () {
          _addRemoveFavourite(products[products.indexOf(element)]);
        },
      ));
    });
    return widgets;
  }

  void _addRemoveFavourite(ProductModel product) {
    var controller = Get.find<ProductDetailsController>();
    Get.find<HomeController>().addRemoveFavourites(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct = controller
              .similarProducts[controller.similarProducts.indexOf(product)];
          myProduct.isFav = !myProduct.isFav;
          controller.update();
          //apply change in filter list
          Get.find<HomeController>()
              .changeFavouriteState(product.id.toString());
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }

  void _addRemoveCart(ProductModel product) {
    var controller = Get.find<ProductDetailsController>();
    Get.find<CartController>().addRemoveCart(
      product.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          var myProduct = controller
              .similarProducts[controller.similarProducts.indexOf(product)];
          myProduct.inCart = !myProduct.inCart;
          controller.update();
          //apply change in filter list
          Get.find<HomeController>().changeInCartState(product.id.toString());
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr, iconData: Icons.error);
        }
      },
    );
  }
}
