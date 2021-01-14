import 'package:flutter/material.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/products_screen/components/products_list.dart';
import 'package:tera/screens/products_screen/components/sub_categories_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LocalStorage().primaryColor(),
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
