import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import '../product_details_screen.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: DirectionalWidget(
        pageUi: GetBuilder<CartController>(
          builder: (controller) => Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: null,
                    //   true
                    //       ? Center(
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.shopping_cart,
                    //                 color: primaryColor,
                    //                 size: 50,
                    //               ),
                    //               SizedBox(
                    //                 height: 30,
                    //               ),
                    //               Text(
                    //                 'Cart is Empty',
                    //                 style: TextStyle(
                    //                     color: Colors.grey, fontSize: 18),
                    //               ),
                    //             ],
                    //           ),
                    //         )
                    //       : ListView.builder(
                    //           itemCount: controller.cart.cartItem.length,
                    //           itemBuilder: (context, index) {
                    //             return _cartItem(
                    //                 context, controller.cart.cartItem[index]);
                    //           },
                    //         ),
                    // ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20),
                          child: Container(
                              height: 50,
                              child: RaisedButton(
                                child: Text('CheckOut'),
                                color: primaryColor,
                                textColor: Colors.white,
                                onPressed: true ? null : () {},
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 20),
                          child: Column(
                            children: [
                              CustomText(
                                text: 'Total',
                                fontSize: 14,
                                alignment: AlignmentDirectional.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                text: true ? '0' : '1500',
                                alignment: AlignmentDirectional.center,
                                fontSize: 20,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cartItem(BuildContext context, ProductModel productModel) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(productModel.id));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 150,
                  placeholder: placeholder,
                  image: productModel.image,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  CustomText(
                    text: productModel.name,
                    maxLines: 2,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: productModel.price.toString(),
                    fontSize: 18,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Constants.backgroundColor,
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 20, start: 20),
                        child: CustomText(
                          text: '3',
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Constants.backgroundColor,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
