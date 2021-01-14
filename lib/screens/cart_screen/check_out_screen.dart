import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/general_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/model/address_model.dart';
import 'package:tera/screens/cart_screen/payment_screen.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/button/custom_outlined_button.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

import '../add_address_screen/add_address_screen.dart';

class CheckOutScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final homeController = Get.find<MainController>();
  final controller = Get.find<GeneralController>();

  CheckOutScreen() {
    controller.getAddressList();
    nameController.text = homeController.user.name;
    phoneController.text = homeController.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Checkout',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPadding,
                ),
                CustomOutlinedTextFormField(
                  hintText: 'name'.tr,
                  labelText: 'name'.tr,
                  controller: nameController,
                  validateEmptyText: 'requiredField'.tr,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomOutlinedTextFormField(
                  hintText: 'phone'.tr,
                  labelText: 'phone'.tr,
                  controller: phoneController,
                  validateEmptyText: 'requiredField'.tr,
                  keyboardType: TextInputType.text,
                  required: true,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomOutlinedTextFormField(
                  required: false,
                  hintText: 'note'.tr,
                  labelText: 'note'.tr,
                  maxLines: 3,
                  controller: detailsController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                _buildAddressMenu(),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                Container(
                  height: 80,
                  padding: EdgeInsetsDirectional.only(bottom: kDefaultPadding),
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'nextToPayment'.tr,
                    colorText: Colors.white,
                    colorBackground: LocalStorage().primaryColor(),
                    fontSize: 20,
                    onPressed: () {
                      _nextToPayment();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAddressMenu() {
    return GetBuilder<GeneralController>(
      init: GeneralController(),
      builder: (controller) => Column(
        children: [
          Visibility(
            child: Column(
              children: [
                CustomText(
                  text: 'noSavedAddress'.tr,
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
                Container(
                  width: MediaQuery.of(Get.context).size.width / 2,
                  child: CustomOutLinedButton(
                    text: 'addAddress'.tr,
                    borderColor: LocalStorage().primaryColor(),
                    colorText: LocalStorage().primaryColor(),
                    onPressed: () async {
                      await Get.to(AddAddressScreen());
                      controller.getAddressList();
                    },
                  ),
                )
              ],
            ),
            visible: controller.addressList.length == 0,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(Get.context).size.width * 0.7,
            child: Center(
              child: DropdownButton<Address>(
                iconDisabledColor: Colors.grey,
                isExpanded: true,
                iconSize: 40,
                itemHeight: 90,
                hint: Center(
                  child: CustomText(
                    text: 'chooseAddress'.tr,
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
                onChanged: (Address address) {
                  controller.setAddress(address);
                },
                value: controller.selectedAddress,
                items: controller.addressList
                    .map<DropdownMenuItem<Address>>(
                      (model) => DropdownMenuItem<Address>(
                        value: model,
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: model.title,
                                fontSize: 18,
                                maxLines: 1,
                                fontWeight: FontWeight.bold,
                                alignment: AlignmentDirectional.centerStart,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                text: model.body,
                                fontSize: 16,
                                maxLines: 1,
                                color: Colors.grey.shade700,
                                alignment: AlignmentDirectional.centerStart,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextToPayment() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //save data to general
      //check address
      Get.to(PaymentScreen());
    }
  }
}
