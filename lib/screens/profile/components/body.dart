import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_outlined_button.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/details_screen/details_screen.dart';
import 'package:flutter_app/screens/profile/components/my_product_card.dart';
import 'package:flutter_app/screens/user_screens/change_password_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
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
                              user != null ? user.photo : defaultImageUrl),
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
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      CustomText(
                        alignment: AlignmentDirectional.center,
                        text: user != null
                            ? user.phone == null
                                ? 'noPhone'.tr
                                : user.phone
                            : '',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      CustomText(
                        alignment: AlignmentDirectional.center,
                        text: user != null ? user.email : '',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: kDefaultPadding/2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CustomOutLinedButton(
                          text: 'changePassword'.tr,
                          onPressed: () {
                            Get.to(ChangePasswordScreen());
                          },
                          colorText: LocalStorage().primaryColor(),
                          colorBackground: Colors.white,
                          borderColor: LocalStorage().primaryColor(),
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
          Get.to(
              DetailsScreen(productId: products[products.indexOf(element)].id));
        },
      ));
    });
    return widgets;
  }
}
