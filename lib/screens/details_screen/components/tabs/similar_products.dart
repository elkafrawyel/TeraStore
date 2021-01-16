import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/screens/details_screen/details_screen.dart';
import 'package:tera/screens/home_screen/components/product_card.dart';

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
      ));
    });
    return widgets;
  }
}
