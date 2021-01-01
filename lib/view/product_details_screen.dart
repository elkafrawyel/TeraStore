import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/cart_view_model.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';

import 'custom_widgets/button/custom_card_button.dart';
import 'custom_widgets/text/custom_decription_text.dart';
import 'custom_widgets/text/custom_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  ProductDetailsScreen(this.productModel);

  @override
  Widget build(BuildContext context) {
    return DirectionalWidget(
      pageUi: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _header(context),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: CustomText(
                                  text: productModel.name,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productModel.price.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                fontSize: 20,
                                text: productModel.discountPrice.toString(),
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                                text: '13 Reviews',
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomCardButton(
                              onPressed: () {
                                Get.find<CartViewModel>()
                                    .addToCart(productModel);
                                CommonMethods().showMessage(
                                    productModel.name, 'is Added to your cart');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'description'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomDescription(
                          text: productModel.description,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 320,
          color: Colors.grey.shade300,
          child: Image.network(
            productModel.image,
            fit: BoxFit.contain,
          ),
        ),
        Visibility(
          visible: true,
          child: PositionedDirectional(
            bottom: 0,
            end: 15,
            child: Image.asset(
              newImage,
              width: 60,
              height: 40,
            ),
          ),
        ),
        PositionedDirectional(
            child: AppBar(
          backgroundColor: Colors.transparent,
          toolbarOpacity: 1,
          elevation: 0.0,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 20),
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
