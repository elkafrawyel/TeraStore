import 'package:flutter/material.dart';
import 'package:flutter_app/a_storage/local_storage.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/products_screen/components/products_list.dart';
import 'package:flutter_app/screens/products_screen/components/sub_categories_list.dart';

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
