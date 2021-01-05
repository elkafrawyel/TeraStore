import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/model/cart_model.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/please_wait_loading.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'details_screen/details_screen.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'cart'.tr,
        elevation: 1,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Container(
          color: Get.find<MainController>().primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.loading.value
                      ? PleaseWaitView()
                      : controller.empty.value
                          ? EmptyView(
                              message: 'emptyCart'.tr,
                              emptyViews: EmptyViews.Box,
                            )
                          : ListView.builder(
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                return _cartItem(
                                    context, controller.products[index], index);
                              },
                            ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: kDefaultPadding,
                      start: kDefaultPadding / 2,
                      bottom: kDefaultPadding,
                      end: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: kDefaultPadding,
                            bottom: kDefaultPadding,
                            end: kDefaultPadding),
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(1),
                            child: RaisedButton(
                              child: Text('CheckOut'.tr),
                              color: Get.find<MainController>().primaryColor,
                              elevation: 1,
                              disabledTextColor: Colors.black,
                              disabledColor: Colors.grey,
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
                              fontSize: 20,
                              color: Colors.black,
                              alignment: AlignmentDirectional.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: controller.products.length == 0
                                  ? '0\$'
                                  : calculateTotalPrice(controller.products)
                                          .toString() +
                                      '\$',
                              alignment: AlignmentDirectional.center,
                              fontSize: 25,
                              color: Colors.black,
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
    );
  }

  Widget _cartItem(BuildContext context, Cart cart, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsScreen(productId: cart.id));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Dismissible(
          key: Key(cart.id),
          direction: DismissDirection.startToEnd,
          background: CustomText(
            text: 'Remove',
            color: Colors.white,
            fontSize: 20,
            alignment: AlignmentDirectional.centerStart,
          ),
          onDismissed: (direction) {
            Get.find<CartController>()
                .removeItem(cart.id, index: index, showLoading: true);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        cart.productModel.image,
                        fit: BoxFit.contain,
                      ),
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
                        fontSize: 16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10),
                        child: CustomText(
                          text:
                              cart.productModel.discountPrice.toString() + '\$',
                          fontSize: 18,
                          color: Get.find<MainController>().primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Container(
                          width: 150,
                          child: Card(
                            color: Get.find<MainController>().primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    add(cart, index);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 2),
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding / 4),
                                  child: CustomText(
                                    text: cart.quantity.toString(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    remove(cart, index);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 2),
                                      child: Icon(
                                        Icons.remove,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  void remove(Cart cart, int index) {
    if (cart.quantity == 1) {
      Get.find<CartController>()
          .removeItem(cart.id, index: index, showLoading: true);
    } else {
      Get.find<CartController>()
          .deleteFromCart(cart.id, index: index, showLoading: true);
    }
  }

  void add(Cart cart, int index) {
    Get.find<CartController>()
        .addToCart(cart.productModel, index: index, showLoading: true);
  }
}
