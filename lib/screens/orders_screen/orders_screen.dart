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
          tapHeaderToExpand: true,
          tapBodyToCollapse: true,
          hasIcon: true,
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
                          height: 20,
                        ),
                        CustomText(
                          text: cartItem.itemName,
                          maxLines: 2,
                          alignment: AlignmentDirectional.topStart,
                          fontSize: 18,
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
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 150,
                          child: Card(
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
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding / 4),
                                  child: CustomText(
                                    text: 'quantity'.tr +
                                        ' ' +
                                        cartItem.cartItemCount.toString(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
          CustomText(
            text: controller.orders[index].getOrderStatus(),
            fontSize: 20,
          ),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.red, width: 1),
            ),
            color: Colors.white,
            onPressed: () {},
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
}
