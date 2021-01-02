import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/model/cart_model.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/view/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/view/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import '../product_details_screen.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen() {
    Get.find<CartController>().getCartItems();
  }

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
                    child: controller.loading.value
                        ? LoadingView()
                        : controller.empty.value
                            ? EmptyView(
                                message: 'Cart is Empty',
                                emptyViews: EmptyViews.Box,
                              )
                            : ListView.builder(
                                itemCount: controller.products.length,
                                itemBuilder: (context, index) {
                                  return _cartItem(context,
                                      controller.products[index], index);
                                },
                              ),
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
                                onPressed: controller.products.length == 0
                                    ? null
                                    : () {},
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
                                text: controller.products.length == 0
                                    ? '0'
                                    : calculateTotalPrice(controller.products)
                                        .toString(),
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

  Widget _cartItem(BuildContext context, Cart cart, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(cart.id));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 140,
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: placeholder,
                  image: cart.productModel.image,
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
                    text: cart.productModel.name,
                    maxLines: 2,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:  EdgeInsetsDirectional.only(start: 10),
                    child: CustomText(
                      text: cart.productModel.discountPrice.toString(),
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: primaryColor)),
                          child: CustomText(
                            text: '+',
                            alignment: AlignmentDirectional.center,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.find<CartController>()
                                .addToCart(cart.productModel, index: index);
                          },
                          color: primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 10, start: 10),
                        child: CustomText(
                          text: cart.quantity.toString(),
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        width: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: primaryColor)),
                          onPressed: () {
                            if (cart.quantity == 1) {
                              Get.find<CartController>()
                                  .deleteFromCart(cart.id, index: index);
                            } else {
                              Get.find<CartController>()
                                  .deleteFromCart(cart.id, index: index);
                            }
                          },
                          child: CustomText(
                            text: '-',
                            alignment: AlignmentDirectional.center,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          color: primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.find<CartController>()
                    .removeItem(cart.id,index);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int calculateTotalPrice(List<Cart> cartItems) {
    int total = 0;
    for (Cart cart in cartItems) {
      total = total + (cart.quantity * cart.productModel.discountPrice);
    }
    return total;
  }
}
