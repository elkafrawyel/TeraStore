import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/data/responses/seller_info_response.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/product_card.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/details_screen/details_screen.dart';

class Body extends StatelessWidget {
  final List<ProductModel> products;
  final SellerInformation sellerInformation;
  final UserModel user;

  Body({this.products, this.sellerInformation, this.user});

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
                color: LocalStorage().primaryColor(),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              user.photo == null ? '' : user.photo),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      CustomText(
                        alignment: AlignmentDirectional.center,
                        text: user.name != null ? user.name : '',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeSmall_16,
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeBig_18,
                            color: Colors.white,
                            text: 'Products',
                          ),
                          Divider(
                            height: 50,
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeSmall_16,
                            color: Colors.white,
                            text: 'Purchase',
                          ),
                          Divider(
                            height: 50,
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeSmall_16,
                            color: Colors.white,
                            text: 'Selling',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeBig_18,
                            color: Colors.white,
                            text: sellerInformation.items.toString(),
                          ),
                          Divider(
                            height: 20,
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeBig_18,
                            color: Colors.white,
                            text: sellerInformation.purchase.toString(),
                          ),
                          Divider(
                            height: 20,
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeBig_18,
                            color: Colors.white,
                            text:
                                sellerInformation.countSoldCartItems.toString(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ])),
        SliverList(
            delegate: SliverChildListDelegate(
          products.length == 0
              ? [
                  Container(
                      child: EmptyView(
                    message: 'noProducts'.tr,
                    textColor: Colors.black,
                  ))
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
          Get.to(DetailsScreen(
              productId: products[products.indexOf(element)].id.toString()));
        },
      ));
    });
    return widgets;
  }
}
