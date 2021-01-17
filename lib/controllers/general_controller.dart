import 'package:tera/a_repositories/general_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/address_model.dart';
import 'package:tera/data/requests/add_address_request.dart';
import 'package:tera/data/responses/locations_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';

class GeneralController extends MainController {
  LocationsResponse locationsResponse;
  Location selectedLocation;
  City selectedCity;
  List<City> cities = [];

  @override
  void onInit() {
    getAllLocations();
    super.onInit();
  }

  void setLocation(Location locationModel) {
    selectedLocation = locationModel;
    cities = selectedLocation.cities;
    selectedCity = null;
    update();
  }

  void setCity(City cityModel) {
    selectedCity = cityModel;
    update();
  }

  getAllLocations() {
    if (locationsResponse == null) {
      loading.value = true;
      update();
      GeneralRepo().getLocations(
        state: (callState) {
          if (callState is Success) {
            locationsResponse = callState.data as LocationsResponse;
            loading.value = false;
            CommonMethods().showSnackBar('Swipe to delete address');
            update();
          } else if (callState is Failure) {
            print(callState.errorMessage);
          }
        },
      );
    }
  }

  AddressModel selectedAddress;
  List<AddressModel> addressList = [];

  setAddress(AddressModel address) {
    selectedAddress = address;
    update();
  }

  getAddressList() async {
    loading.value = true;
    GeneralRepo().getAddresses(
      state: (callState) {
        if (callState is Success) {
          addressList.clear();
          addressList.addAll(callState.data as List<AddressModel>);
          loading.value = false;
          if (addressList.isEmpty) {
            empty.value = true;
          } else {
            empty.value = false;
          }
          update();
        } else if (callState is Failure) {
          print(callState.errorMessage);
        }
      },
    );
  }

  addAddress(AddAddressRequest addressRequest,
      {Function(DataResource dataResource) dataSource}) async {
    if (selectedLocation == null) {
      CommonMethods().showSnackBar('Choose from the list');
      return;
    }
    if (selectedCity == null) {
      CommonMethods().showSnackBar('Choose from the list');
      return;
    }
    addressRequest.governorate = selectedLocation.nameEn;
    addressRequest.city = selectedCity.nameEn;
    loading.value = true;
    update();
    await GeneralRepo().addAddress(
      addressRequest,
      state: (callState) {
        if (callState is Success) {
          dataSource(Success(data: callState.data));
          loading.value = false;
          update();
          getAddressList();
        } else if (callState is Failure) {
          loading.value = false;
          update();
          dataSource(Failure(errorMessage: callState.errorMessage));
        }
      },
    );
  }

  void deleteAddress(int index) {
    update();
    GeneralRepo().deleteUserAdress(
      addressList[index].id.toString(),
      state: (callState) {
        if (callState is Success) {
          addressList.removeAt(index);
          if (addressList.isEmpty) {
            empty.value = true;
          } else {
            empty.value = false;
          }
          update();
        } else if (callState is Failure) {
          print('Failed to delete address');
        }
      },
    );
  }
}
