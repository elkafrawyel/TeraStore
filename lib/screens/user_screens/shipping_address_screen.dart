import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/general_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/user_screens/add_address_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

class ShippingAddresses extends StatelessWidget {
  ShippingAddresses() {
    Get.put(GeneralController()).getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'shippingAddresses'.tr,
      ),
      body: GetBuilder<GeneralController>(
        builder: (controller) => Column(
          children: [
            Expanded(
              child: controller.loading.value
                  ? LoadingView()
                  : controller.empty.value
                      ? EmptyView()
                      : ListView.builder(
                          itemCount: controller.addressList.length,
                          itemBuilder: (context, index) {
                            return _addressCard(index, controller);
                          },
                        ),
            ),
            Container(
              height: 80,
              padding: EdgeInsetsDirectional.only(bottom: kDefaultPadding),
              width: MediaQuery.of(context).size.width / 2,
              child: CustomButton(
                text: 'addAddress'.tr,
                colorText: Colors.white,
                colorBackground: LocalStorage().primaryColor(),
                fontSize: 20,
                onPressed: () {
                  Get.to(AddAddressScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addressCard(int index, GeneralController controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: kDefaultPadding,
          top: kDefaultPadding,
          bottom: kDefaultPadding),
      child: Column(
        children: [
          CustomText(
            text: '${index + 1} - ${controller.addressList[index].title}',
            alignment: AlignmentDirectional.centerStart,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          CustomText(
            text: controller.addressList[index].body,
            alignment: AlignmentDirectional.centerStart,
            fontSize: 18,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
