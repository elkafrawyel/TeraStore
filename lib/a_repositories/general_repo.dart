import 'package:chopper/chopper.dart' as chopper;
import 'package:get/get.dart';
import 'package:tera/a_repositories/user_repo.dart';
import 'package:tera/a_storage/network/address/address_service.dart';
import 'package:tera/data/responses/locations_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/network_methods.dart';
import 'package:tera/model/address_model.dart';

class GeneralRepo {
  getLocations(Function(LocationsResponse locationsResponse) callback) async {
    AddressService service = AddressService.create();

    chopper.Response response = await service.getGovernorates();
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        LocationsResponse locationsResponse =
            LocationsResponse.fromJson(response.body);
        callback(locationsResponse);
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
        break;
    }
  }

  Future<void> addAddress(Address address) async {}
}
