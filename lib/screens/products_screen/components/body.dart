import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/products_screen/components/products_list.dart';
import 'package:flutter_app/screens/products_screen/components/sub_categories_list.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.find<MainController>().primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          SubCategoriesList(),
          SizedBox(
            height: kDefaultPadding,
          ),
          Expanded(child: ProductsList()),
        ],
      ),
    );
  }
}
