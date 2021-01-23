import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/orders_controller.dart';
import 'package:tera/data/models/cart_model.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/error_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class OrdersScreen extends StatelessWidget {
  final controller = Get.find<OrdersController>();

  OrdersScreen() {
    controller.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      init: OrdersController(),
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          text: 'myOrders'.tr,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.loading.value
                ? LoadingView()
                : controller.empty.value
                    ? Center(
                        child: EmptyView(
                          message: 'noOrders'.tr,
                          emptyViews: EmptyViews.Box,
                          textColor: Colors.black,
                        ),
                      )
                    : controller.error.value
                        ? ErrorView()
                        : _ordersList(),
          ),
        ),
      ),
    );
  }

  _ordersList() {
    return ListView.builder(
      itemCount: controller.orders.length,
      itemBuilder: (context, index) {
        return ExpandablePanel(
          header: _hearView(index),
          expanded: _buildSubItems(index),
        );
      },
    );
  }

  final cardHeight = 180.0;

  Widget _orderItem(CartItem cartItem) {
    return Container(
      width: MediaQuery.of(Get.context).size.width,
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
              width: 150,
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
                          height: kDefaultPadding,
                        ),
                        CustomText(
                          text: cartItem.itemName,
                          maxLines: 2,
                          alignment: AlignmentDirectional.topStart,
                          fontSize: fontSizeSmall_16,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: CustomText(
                            alignment: AlignmentDirectional.topStart,
                            text: cartItem.itemPriceAfterDis.toString() + '\$',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: kDefaultPadding,
                                    end: kDefaultPadding,
                                    top: kDefaultPadding / 4,
                                    bottom: kDefaultPadding / 4),
                                child: CustomText(
                                  text: 'quantity'.tr +
                                      ' ' +
                                      cartItem.cartItemCount.toString(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall_16,
                                  color: Colors.white,
                                ),
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
    );
  }

  _hearView(int index) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: controller.orders[index].getOrderStatus(),
                fontSize: fontSizeSmall_16,
                color: _getColor(index),
              ),
              CustomText(
                text: controller.orders[index].shippingAdress,
                fontSize: fontSizeSmall_16,
                color: Colors.black,
              ),
            ],
          ),
          Visibility(
            visible: controller.orders[index].cartOrderStatus ==
                'primaryUserApprove',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.red, width: 1),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: Get.context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("confirm".tr),
                            content: Text('deleteMessage'.tr),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.deleteOrder(
                                        controller.orders[index].id.toString());
                                  },
                                  child: Text('delete'.tr)),
                              FlatButton(
                                onPressed: () => Get.back(),
                                child: Text('cancel'.tr),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: CustomText(
                    text: 'Delete',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSubItems(int index) {
    List<Widget> widget = [];

    SizedBox(
      height: kDefaultPadding / 2,
    );
    for (CartItem cartItem in controller.orders[index].cartItems) {
      widget.add(_orderItem(cartItem));
    }

    SizedBox(
      height: kDefaultPadding / 2,
    );

    return Column(children: widget);
  }

  _getColor(int index) {
    switch (controller.orders[index].cartOrderStatus) {
      case 'primaryUserApprove':
        return Colors.green;
      case 'acceptShipping':
        return Colors.blue;
      case 'operationDone':
        return Colors.green;
      case 'inShipping':
        return Colors.black;
      case 'delayed':
        return Colors.yellow;
      case 'canceled':
        return Colors.red;
      case 'delivered':
        return Colors.green;
    }
  }
}
