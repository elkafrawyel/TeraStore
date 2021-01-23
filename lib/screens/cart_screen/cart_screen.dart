import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/data/models/cart_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/cart_screen/check_out_screen.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

import '../details_screen/details_screen.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'cart'.tr,
        elevation: 1,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.empty.value
                      ? EmptyView(
                          message: 'emptyCart'.tr,
                          emptyViews: EmptyViews.Magnifier,
                        )
                      : ListView.builder(
                          itemCount: controller.cart.cartItems.length,
                          itemBuilder: (context, index) {
                            return _cartItem(context,
                                controller.cart.cartItems[index], index);
                          },
                        ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: LocalStorage().primaryColor(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: kDefaultPadding / 2,
                      start: kDefaultPadding / 2,
                      bottom: kDefaultPadding / 2,
                      end: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Container(
                          height: 50,
                          child: RaisedButton.icon(
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            label: CustomText(
                              text: 'confirm'.tr,
                              fontSize: fontSizeSmall_16,
                              alignment: AlignmentDirectional.center,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            color:
                                LocalStorage().primaryColor().withOpacity(0.6),
                            elevation: 1,
                            disabledTextColor: Colors.black,
                            disabledColor: Colors.grey,
                            textColor: Colors.white,
                            onPressed: controller.cart == null
                                ? null
                                : () async {
                                    Get.to(
                                      CheckOutScreen(),
                                    );
                                  },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'total'.tr,
                              fontSize: fontSizeSmall_16,
                              color: Colors.white,
                              alignment: AlignmentDirectional.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: controller.cart == null
                                  ? '0\$'
                                  : controller.cart.cartTotalPrice.toString() +
                                      '\$',
                              alignment: AlignmentDirectional.center,
                              fontSize: fontSizeSmall_16,
                              color: Colors.white,
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

  final cardHeight = 220.0;

  Widget _cartItem(BuildContext context, CartItem cartItem, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsScreen(productId: cartItem.itemId.toString()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Dismissible(
          confirmDismiss: (direction) async {
            return await showDialog(
              context: Get.context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("confirm".tr),
                  content: Text('deleteMessage'.tr),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('delete'.tr)),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('cancel'.tr),
                    ),
                  ],
                );
              },
            );
          },
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.red,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: kDefaultPadding * 2,
                ),
                Image.asset(
                  deleteImage,
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          onDismissed: (direction) {
            controller.addRemoveCart(
              cartItem.itemId.toString(),
              state: (dataResource) {
                if (dataResource is Success) {
                  //apply change in filter list
                  Get.find<HomeController>()
                      .changeInCartState(cartItem.itemId.toString());
                } else if (dataResource is Failure) {
                  CommonMethods()
                      .showSnackBar('error'.tr, iconData: Icons.error);
                }
              },
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: kCardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: cardHeight,
                  width: 180,
                  child: LocalStorage().isArabicLanguage()
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(22),
                            bottomRight: Radius.circular(22),
                            bottomLeft: Radius.circular(0),
                          ),
                          child: FadeInImage.assetNetwork(
                            image: cartItem.itemImage,
                            placeholder: placeholder,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(0),
                          ),
                          child: FadeInImage.assetNetwork(
                            image: cartItem.itemImage,
                            placeholder: placeholder,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: cardHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: kDefaultPadding / 2,
                            ),
                            CustomText(
                              text: cartItem.itemName,
                              maxLines: 2,
                              alignment: AlignmentDirectional.topStart,
                              fontSize: fontSizeSmall_16,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: kDefaultPadding / 2,
                            ),
                            Visibility(
                              visible: cartItem.properitiesDescription != null,
                              child: CustomText(
                                text: cartItem.properitiesDescription,
                                maxLines: 4,
                                alignment: AlignmentDirectional.topStart,
                                fontSize: fontSizeSmall_16 - 2,
                              ),
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              child: CustomText(
                                alignment: AlignmentDirectional.topStart,
                                text: cartItem.itemPriceAfterDis.toString() +
                                    ' $currency',
                                fontSize: fontSizeSmall_16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                              color: LocalStorage().primaryColor(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                    bottomEnd: Radius.circular(20),
                                    topStart: Radius.circular(20)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      add(cartItem, index);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding / 2),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 4),
                                    child: CustomText(
                                      text: cartItem.cartItemCount.toString(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeSmall_16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      remove(cartItem, index);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding / 2),
                                        child: Icon(
                                          Icons.remove,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void remove(CartItem cartItem, int index) {
    controller.cartItemPlusMinus(cartItem.itemId.toString(), 'min');
  }

  void add(CartItem cartItem, int index) {
    controller.cartItemPlusMinus(cartItem.itemId.toString(), 'plus');
  }
}
