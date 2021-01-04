import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_cart_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/details_screen/components/tabs/tabs_view.dart';
import 'package:get/get.dart';
import 'product_poster.dart';

class Body extends StatelessWidget {
  final ProductModel product;

  Body({Key key, this.product});

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
                  delegate: SliverChildListDelegate(
                    [
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
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding),
                                child: CustomText(
                                  text: product.name,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: kDefaultPadding / 2,
                                    ),
                                    Text(
                                      '\$${product.discountPrice}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  TabView(),
                ]))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _addToCart(ProductModel productModel) async {
    await Get.put(CartController()).addToCart(productModel);
  }
}
