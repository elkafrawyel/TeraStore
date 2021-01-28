import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/data/responses/seller_info_response.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/change_password_screen.dart';
import 'package:tera/screens/custom_widgets/button/custom_outlined_button.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/details_screen/details_screen.dart';
import 'package:tera/screens/profile/components/my_product_card.dart';

class Body extends StatelessWidget {
  final List<ProductModel> products;
  final UserModel user;
  final SellerInformation myInformation;

  Body({this.products, this.user, this.myInformation});

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
                          backgroundImage: NetworkImage(user.photo),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      CustomText(
                        alignment: AlignmentDirectional.center,
                        text: user != null ? user.name : '',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeBig_18,
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      Visibility(
                        visible: user.phone != null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              alignment: AlignmentDirectional.center,
                              text: user.phone,
                              fontSize: fontSizeSmall_16 - 2,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: kDefaultPadding / 2,
                            ),
                            Icon(
                              Icons.verified_user_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      CustomText(
                        alignment: AlignmentDirectional.center,
                        text: user != null ? user.email : '',
                        fontSize: fontSizeSmall_16 - 2,
                        maxLines: 2,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      Visibility(
                        visible: user.socialType == null,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: CustomOutLinedButton(
                            text: 'changePassword'.tr,
                            onPressed: () {
                              Get.to(ChangePasswordScreen());
                            },
                            colorText: LocalStorage().primaryColor(),
                            colorBackground: Colors.white,
                            borderColor: LocalStorage().primaryColor(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            alignment: AlignmentDirectional.center,
                            fontSize: fontSizeSmall_16,
                            color: Colors.white,
                            text: 'Products'.tr,
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
                            text: 'Purchase'.tr,
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
                            text: 'Selling'.tr,
                          )
                        ],
                      ),
                      myInformation == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: CircularProgressIndicator()),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomText(
                                  alignment: AlignmentDirectional.center,
                                  fontSize: fontSizeBig_18,
                                  color: Colors.white,
                                  text: myInformation.items.toString(),
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
                                  text: myInformation.purchase.toString(),
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
                                  text: myInformation.countSoldCartItems
                                      .toString(),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomText(
            text: 'myProducts'.tr,
            fontSize: fontSizeSmall_16,
            alignment: AlignmentDirectional.center,
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
      widgets.add(MyProductCard(
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
