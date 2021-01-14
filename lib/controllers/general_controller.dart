import 'package:tera/a_repositories/general_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/responses/locations_response.dart';
import 'package:tera/model/address_model.dart';

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
      GeneralRepo().getLocations((locationsResponse) {
        this.locationsResponse = locationsResponse;
        loading.value = false;
        update();
      });
    }
  }

  Address selectedAddress;
  List<Address> addressList = [];

  setAddress(Address address) {
    selectedAddress = address;
    update();
  }

  getAddressList() async {
    // loading.value = true;
    // List<Address> list = await GeneralRepo().getLocations();
    // addressList.clear();
    // addressList.addAll(list);
    // loading.value = false;
    // if (addressList.isEmpty) {
    //   empty.value = true;
    // } else {
    //   empty.value = false;
    // }
    // update();
  }

  addAddress(Address address) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    address.id = id.toString();
    await GeneralRepo().addAddress(address);
    getAddressList();
  }
}
