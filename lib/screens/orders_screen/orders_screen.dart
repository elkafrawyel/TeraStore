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
  final OrdersController controller = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      init: OrdersController(),
      dispose: (state) {
        print('dispose');
      },
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          text: 'myOrders'.tr,
        ),
        body: Container(
          color: Constants.backgroundColor,
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
          theme: ExpandableThemeData(
              iconColor: Colors.black,
              collapseIcon: Icons.arrow_upward,
              expandIcon: Icons.arrow_downward,
              tapBodyToCollapse: true,
              animationDuration: (Duration(milliseconds: 800)),
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          header: _hearView(index),
          expanded: _buildSubItems(index),
        );
      },
    );
  }

  final cardHeight = 150.0;

  Widget _orderItem(CartItem cartItem) {
    return Container(
      width: MediaQuery.of(Get.context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
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
                          height: kDefaultPadding / 2,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: CustomText(
                            alignment: AlignmentDirectional.topStart,
                            text: cartItem.itemPriceAfterDis.toString() +
                                ' ' +
                                'currency'.tr,
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
                                  fontSize: fontSizeSmall_16 - 2,
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: controller.orders[index].getOrderStatus(),
                  fontSize: fontSizeSmall_16,
                  color: _getColor(index),
                  alignment: AlignmentDirectional.centerStart,
                ),
                Visibility(
                  visible: controller.orders[index].cartOrderStatus ==
                      'primaryUserApprove',
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: Get.context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "confirm".tr,
                                style:
                                    TextStyle(fontSize: fontSizeSmall_16 - 2),
                              ),
                              content: Text('deleteMessage'.tr,
                                  style: TextStyle(
                                      fontSize: fontSizeSmall_16 - 2)),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteOrder(controller
                                          .orders[index].id
                                          .toString());
                                    },
                                    child: Text('delete'.tr,
                                        style: TextStyle(
                                            fontSize: fontSizeSmall_16 - 2))),
                                FlatButton(
                                  onPressed: () => Get.back(),
                                  child: Text('cancel'.tr,
                                      style: TextStyle(
                                          fontSize: fontSizeSmall_16 - 2)),
                                ),
                              ],
                            );
                          });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: kDefaultPadding / 4,
                bottom: kDefaultPadding / 2,
              ),
              child: Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
            ),
            CustomText(
              text: controller.orders[index].shippingAdress,
              fontSize: fontSizeSmall_16,
              color: Colors.black,
            ),
          ],
        ),
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
