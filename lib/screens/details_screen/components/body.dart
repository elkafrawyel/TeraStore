import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_cart_button.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_outlined_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_description_text.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/details_screen/components/owner_info.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';
import 'list_of_colors.dart';
import 'product_poster.dart';

class Body extends StatelessWidget {
  final ProductModel product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          margin: EdgeInsetsDirectional.only(top: 0),
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(50),
                // bottomRight: Radius.circular(50),
                // topRight: Radius.circular(50),
                // topLeft: Radius.circular(50),
                ),
          ),
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.topCenter,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: kDefaultPadding,
                          end: kDefaultPadding,
                          start: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: ProductPoster(
                              image: product.image,
                            ),
                          ),
                          // ListOfColors(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 2),
                            child: Text(
                              product.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '\$${product.discountPrice}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width / 3,
                                child: CustomCartButton(
                                  onPressed: () {
                                    _addToCart(product);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          _rating(),
                          product.owner == null
                              ? Container()
                              : OwnerInfo(
                                  owner: product.owner,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      child: CustomText(
                        text: 'description'.tr,
                        fontSize: 18,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: kDefaultPadding, end: kDefaultPadding),
                        child: CustomDescription(
                          text: product.description,
                        )),
                    SizedBox(height: kDefaultPadding),
                  ]))
                ],
              )),
        ),
      ],
    );
  }

  void _addToCart(ProductModel productModel) async {
    Get.put(CartController()).addToCart(productModel).then((value) {
      CommonMethods().showMessage(productModel.name, 'addedToCart'.tr);
    });
  }

  _rating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomOutLinedButton(
          text: 'addComment'.tr,
          colorText: Get.find<MainController>().primaryColor,
          onPressed: () {},
          borderColor: Get.find<MainController>().primaryColor,
        ),
        Column(
          children: [
            RatingBar.readOnly(
              initialRating: 3.5,
              isHalfAllowed: true,
              size: 20,
              filledColor: Colors.amber,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
            ),
            SizedBox(
              height: 5,
            ),
            CustomText(
              text: '1253 ${'reviews'.tr}',
              fontSize: 12,
              alignment: AlignmentDirectional.center,
              color: Colors.grey.shade600,
            )
          ],
        ),
      ],
    );
  }
}
