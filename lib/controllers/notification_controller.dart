import 'package:tera/a_repositories/general_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/responses/notification_response.dart';
import 'package:tera/helper/data_resource.dart';

class NotificationController extends MainController {
  List<NotificationModel> notifications = [];

  getNotification() async {
    loading.value = true;
    GeneralRepo().getNotification(
      state: (callState) {
        if (callState is Success) {
          notifications.clear();
          notifications.addAll(callState.data as List<NotificationModel>);
          loading.value = false;
          empty.value = notifications.isEmpty;
          update();
        } else if (callState is Failure) {
          print(callState.errorMessage);
        }
      },
    );
  }
}
