import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/details_screen/details_screen.dart';
import 'package:flutter_app/screens/main_screen/components/product_card.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  final List<ProductModel> products;
  final UserModel user;

  Body({this.products, this.user});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Get.find<MainController>().primaryColor,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              user != null ? user.photo : defaultImageUrl),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              alignment: AlignmentDirectional.centerStart,
                              text: user != null ? user.name : '',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              alignment: AlignmentDirectional.centerStart,
                              text: user != null
                                  ? user.phone == null
                                      ? 'noPhone'.tr
                                      : user.phone
                                  : '',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              alignment: AlignmentDirectional.centerStart,
                              text: user != null ? user.email : '',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomText(
            text: 'myProducts'.tr,
            fontSize: 20,
            alignment: AlignmentDirectional.center,
          ),
        ])),
        SliverList(
            delegate: SliverChildListDelegate(
          products.length == 0
              ? [
                  Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: EmptyView(message: 'noProducts'.tr))
                ]
              : _myProducts(),
        ))
      ],
    );
  }

  List<Widget> _myProducts() {
    List<Widget> widgets = [];
    products.forEach((element) {
      widgets.add(ProductCard(
        itemIndex: products.indexOf(element),
        product: products[products.indexOf(element)],
        press: () {
          Get.to(
              DetailsScreen(productId: products[products.indexOf(element)].id));
        },
      ));
    });
    return widgets;
  }
}
