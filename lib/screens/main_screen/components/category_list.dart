import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/home_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/products_screen/products_screen.dart';
import 'package:get/get.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 50,
      child: GetBuilder<HomeController>(
        builder: (controller) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              controller.selectedCategoryIndex = index;
              //go to sub category screen
              Get.to(
                ProductsScreen(
                  categoryModel: controller.categories[index],
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: kDefaultPadding / 3,
                right: kDefaultPadding / 2,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomText(
                text: controller.categories[index].displayName,
                alignment: AlignmentDirectional.center,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
