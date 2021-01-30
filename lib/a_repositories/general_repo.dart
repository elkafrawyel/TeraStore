import 'package:tera/a_storage/network/general/general_service.dart';
import 'package:tera/data/requests/add_address_request.dart';
import 'package:tera/data/responses/add_address_response.dart';
import 'package:tera/data/responses/get_addresses_response.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/locations_response.dart';
import 'package:tera/data/responses/notification_response.dart';
import 'package:tera/data/responses/privacy_policy_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';

class GeneralRepo {
  getLocations({Function(DataResource callState) state}) async {
    GeneralService service = GeneralService.create();

    NetworkMethods().handleResponse(
        call: service.getGovernorates(),
        whenSuccess: (response) {
          LocationsResponse locationsResponse =
              LocationsResponse.fromJson(response.body);
          if (locationsResponse.status) {
            state(Success(data: locationsResponse));
          } else {
            state(Failure(errorMessage: 'Failed to get Locations'));
          }
        });
  }

  addAddress(AddAddressRequest addressRequest,
      {Function(DataResource callState) state}) async {
    GeneralService service = GeneralService.create();

    NetworkMethods().handleResponse(
        call: service.addAddress(addressRequest),
        whenSuccess: (response) {
          AddAddressResponse addAddressResponse =
              AddAddressResponse.fromJson(response.body);
          if (addAddressResponse.status) {
            state(Success(data: addAddressResponse.message));
          } else {
            state(Failure(errorMessage: 'Failed to add address'));
          }
        });
  }

  getAddresses({Function(DataResource callState) state}) async {
    GeneralService service = GeneralService.create();

    NetworkMethods().handleResponse(
        call: service.getAddresses(),
        whenSuccess: (response) {
          AddressesResponse addressesResponse =
              AddressesResponse.fromJson(response.body);
          if (addressesResponse.status) {
            state(Success(data: addressesResponse.data));
          } else {
            state(
              Failure(errorMessage: 'Failed to get addresses'),
            );
          }
        });
  }

  deleteUserAdress(String addressId,
      {Function(DataResource callState) state}) async {
    GeneralService service = GeneralService.create();

    NetworkMethods().handleResponse(
        call: service.deleteUserAdress(addressId),
        whenSuccess: (response) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            CommonMethods().showSnackBar(infoResponse.message);
            state(Success());
          } else {
            state(Failure());
          }
        });
  }

  getNotification({Function(DataResource callState) state}) async {
    GeneralService service = GeneralService.create();

    NetworkMethods().handleResponse(
        call: service.getNotification(),
        whenSuccess: (response) {
          NotificationResponse notificationResponse =
              NotificationResponse.fromJson(response.body);
          if (notificationResponse.status) {
            state(Success(data: notificationResponse.notifications));
          } else {
            state(Failure());
          }
        });
  }

  getPrivacyPolicies({Function(DataResource callState) state}) async {
    GeneralService service = GeneralService.create();

    NetworkMethods().handleResponse(
        call: service.getPrivacyPolicies(),
        whenSuccess: (response) {
          PrivacyPoliciesResponse privacyPoliciesResponse =
              PrivacyPoliciesResponse.fromJson(response.body);
          if (privacyPoliciesResponse.status) {
            state(Success(data: privacyPoliciesResponse.data));
          } else {
            state(Failure());
          }
        });
  }
}
