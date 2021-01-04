import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/main_screen/components/product_card.dart';
import 'package:get/get.dart';

class SimilarProducts extends StatelessWidget {
  final List<ProductModel> products;

  SimilarProducts({this.products});

  @override
  Widget build(BuildContext context) {
    return _productsList();
  }

  _productsList() {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      height: MediaQuery.of(Get.context).size.height / 2,
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: products.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ProductCard(
            itemIndex: index,
            product: products[index],
            press: () {},
          );
        },
      ),
    );
  }
}
