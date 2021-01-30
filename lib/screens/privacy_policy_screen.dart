import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/privacy_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final controller = Get.put(PrivacyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'privacy'.tr,
      ),
      body: GetBuilder<PrivacyController>(
        init: PrivacyController(),
        builder: (controller) => controller.loading.value
            ? LoadingView()
            : Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return policyChild(index);
                  },
                  itemCount: controller.policies.length,
                ),
              ),
      ),
    );
  }

  Widget policyChild(int index) {
    return ExpandablePanel(
      theme: ExpandableThemeData(
          iconColor: Colors.black,
          collapseIcon: Icons.arrow_upward,
          expandIcon: Icons.arrow_downward,
          tapBodyToCollapse: true,
          headerAlignment: ExpandablePanelHeaderAlignment.center),
      header: _hearView(index),
      expanded: _bodyView(index),
    );
  }

  _hearView(int index) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: kDefaultPadding / 2,
          bottom: kDefaultPadding,
          top: kDefaultPadding / 2),
      child: CustomText(
        text: '-${controller.policies[index].title()}',
        fontSize: fontSizeSmall_16,
      ),
    );
  }

  _bodyView(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomText(
            text: controller.policies[index].body(),
            fontSize: fontSizeSmall_16 - 2,
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            width: MediaQuery.of(Get.context).size.width,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: kDefaultPadding / 2,
                  end: kDefaultPadding / 2,
                  top: kDefaultPadding / 2,
                  bottom: kDefaultPadding / 2),
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
