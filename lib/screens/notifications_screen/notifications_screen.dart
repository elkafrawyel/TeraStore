import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/notification_controller.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/orders_screen/orders_screen.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  NotificationsScreen() {
    controller.getNotification();
    if (LocalStorage().isArabicLanguage())
      initializeDateFormatting("ar_SA", null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'notifications'.tr,
      ),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          return controller.loading.value
              ? LoadingView()
              : controller.empty.value
                  ? EmptyView(
                      textColor: Colors.black,
                    )
                  : Container(
                      color: Constants.backgroundColor,
                      padding: const EdgeInsetsDirectional.only(
                          top: kDefaultPadding / 4),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return _buildItem(index);
                        },
                        itemCount: controller.notifications.length,
                      ),
                    );
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: kDefaultPadding / 4),
      child: ListTile(
        leading: FadeInImage.assetNetwork(
          placeholder: placeholder,
          image: controller.notifications[index].image,
          fit: BoxFit.cover,
          width: 60,
          height: 120,
        ),
        title: CustomText(
          text: controller.notifications[index].title,
          fontSize: fontSizeSmall_16 - 2,
        ),
        subtitle: Column(
          children: [
            CustomText(
              text: controller.notifications[index].body,
              fontSize: fontSizeSmall_16 - 4,
              color: Colors.grey.shade700,
              maxLines: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: CommonMethods().timeAgoSinceDate(
                      controller.notifications[index].unixTime),
                  fontSize: fontSizeSmall_16 - 2,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        tileColor: Colors.white,
        // controller.notifications[index].read == 'yes'
        //     ? Colors.white
        //     : Colors.grey.shade300,
        dense: false,
        isThreeLine: true,
        onTap: () {
          if (controller.notifications[index].type == 'order') {
            Get.to(OrdersScreen(), transition: Transition.zoom);
          } else {}
        },
      ),
    );
  }
}
