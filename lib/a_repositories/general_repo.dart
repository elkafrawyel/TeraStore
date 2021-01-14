import 'package:tera/a_storage/network/address/address_service.dart';
import 'package:tera/data/requests/add_address_request.dart';
import 'package:tera/data/responses/add_address_response.dart';
import 'package:tera/data/responses/get_addresses_response.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/locations_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';

class GeneralRepo {
  getLocations({Function(DataResource callState) state}) async {
    AddressService service = AddressService.create();

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

  Future<void> addAddress(AddAddressRequest addressRequest,
      {Function(DataResource callState) state}) async {
    AddressService service = AddressService.create();

    NetworkMethods().handleResponse(
        call: service.addAddress(addressRequest),
        whenSuccess: (response) {
          AddAddressResponse addAddressResponse =
              AddAddressResponse.fromJson(response.body);
          if (addAddressResponse.status) {
            CommonMethods().showSnackBar(addAddressResponse.message);
            state(Success());
          } else {
            state(Failure(errorMessage: 'Failed to add address'));
          }
        });
  }

  Future<void> getAddresses({Function(DataResource callState) state}) async {
    AddressService service = AddressService.create();

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

  Future<void> deleteUserAdress(String addressId,
      {Function(DataResource callState) state}) async {
    AddressService service = AddressService.create();

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
}
