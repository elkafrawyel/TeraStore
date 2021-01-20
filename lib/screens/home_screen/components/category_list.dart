import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/products_screen/products_screen.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
      height: 70,
      child: GetBuilder<HomeController>(
        init: HomeController(),
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
              margin: EdgeInsetsDirectional.only(
                start: kDefaultPadding / 4,
                end: kDefaultPadding / 4,
              ),
              padding: EdgeInsetsDirectional.only(
                start: kDefaultPadding,
                end: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.storage,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding / 2),
                    child: CustomText(
                      text: controller.categories[index].displayName,
                      alignment: AlignmentDirectional.center,
                      color: Colors.white,
                      fontSize: fontSizeSmall_16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
