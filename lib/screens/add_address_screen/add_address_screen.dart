import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/general_controller.dart';
import 'package:tera/data/requests/add_address_request.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/add_address_screen/components/locations_menu.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';

import '../custom_widgets/text/custom_outline_text_form_field.dart';

class AddAddressScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'addAddress'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: GetBuilder<GeneralController>(
          builder: (controller) => Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      CustomOutlinedTextFormField(
                        text: 'title'.tr,
                        hintText: 'title'.tr,
                        labelText: 'title'.tr,
                        controller: titleController,
                        validateEmptyText: 'requiredField'.tr,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomOutlinedTextFormField(
                        text: 'details'.tr,
                        hintText: 'details'.tr,
                        labelText: 'details'.tr,
                        controller: detailsController,
                        maxLines: 4,
                        validateEmptyText: 'requiredField'.tr,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LocationsMenu(),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 80,
                        padding:
                            EdgeInsetsDirectional.only(bottom: kDefaultPadding),
                        width: MediaQuery.of(context).size.width / 4,
                        child: CustomButton(
                          text: 'add'.tr,
                          colorText: Colors.white,
                          colorBackground: LocalStorage().primaryColor(),
                          fontSize: 20,
                          onPressed: () {
                            _add();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: Visibility(
                  visible: controller.loading.value,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _add() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AddAddressRequest addressRequest = AddAddressRequest(
        title: titleController.text,
        completeAdress: detailsController.text,
      );
      var controller = Get.find<GeneralController>();
      controller.addAddress(
        addressRequest,
        dataSource: (dataResource) {
          if (dataResource is Success) {
            CommonMethods().hideKeyboard();
            CommonMethods().showSnackBar(dataResource.data.toString());
            titleController.text = '';
            detailsController.text = '';
            controller.selectedLocation = null;
            controller.selectedCity = null;
          } else if (dataResource is Failure) {
            CommonMethods().showSnackBar(dataResource.errorMessage);
          }
        },
      );
    }
  }
}
