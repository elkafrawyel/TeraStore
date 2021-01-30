import 'package:tera/a_repositories/general_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/responses/privacy_policy_response.dart';
import 'package:tera/helper/data_resource.dart';

class PrivacyController extends MainController {
  List<PrivacyPolicyModel> policies = [];

  @override
  onInit() {
    super.onInit();
    getPolicies();
  }

  getPolicies() async {
    loading.value = true;
    GeneralRepo().getPrivacyPolicies(
      state: (callState) {
        if (callState is Success) {
          policies.clear();
          policies.addAll(callState.data as List<PrivacyPolicyModel>);
          loading.value = false;
          empty.value = policies.isEmpty;
          update();
        } else if (callState is Failure) {
          print(callState.errorMessage);
        }
      },
    );
  }
}
