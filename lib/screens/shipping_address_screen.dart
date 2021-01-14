import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/general_controller.dart';
import 'package:tera/data/models/address_model.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';

import 'add_address_screen/add_address_screen.dart';
import 'custom_widgets/text/custom_text.dart';

class ShippingAddresses extends StatelessWidget {
  final controller = Get.find<GeneralController>();

  ShippingAddresses() {
    controller.getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'shippingAddresses'.tr,
      ),
      body: GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller) => Column(
          children: [
            Expanded(
              child: controller.loading.value
                  ? LoadingView()
                  : controller.empty.value
                      ? EmptyView(
                          textColor: Colors.black,
                          message: 'noSavedAddress'.tr,
                          emptyViews: EmptyViews.Magnifier,
                        )
                      : ListView.builder(
                          itemCount: controller.addressList.length,
                          itemBuilder: (context, index) {
                            return _addressCard(
                                index, controller.addressList[index]);
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
                onPressed: () async {
                  await Get.to(AddAddressScreen());
                  Get.find<GeneralController>().selectedLocation = null;
                  Get.find<GeneralController>().selectedCity = null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addressCard(int index, AddressModel addressModel) {
    return Dismissible(
      key: Key(addressModel.id.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        controller.deleteAddress(index);
      },
      background: Container(
        color: Colors.red,
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
      child: Padding(
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
            Row(
              children: [
                CustomText(
                  text: controller.addressList[index].governorate + ' , ',
                  alignment: AlignmentDirectional.centerStart,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
                CustomText(
                  text: controller.addressList[index].city,
                  alignment: AlignmentDirectional.centerStart,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            CustomText(
              text: controller.addressList[index].completeAdress,
              alignment: AlignmentDirectional.centerStart,
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }
}
