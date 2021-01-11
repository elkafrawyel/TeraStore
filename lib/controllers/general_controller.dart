import 'package:flutter_app/a_repositories/general_repo.dart';
import 'package:flutter_app/controllers/main_controller.dart';
import 'package:flutter_app/model/address_model.dart';

class GeneralController extends MainController {
  Address selectedAddress;
  List<Address> addressList = [];

  setAddress(Address address) {
    selectedAddress = address;
    update();
  }

  getAddressList() async {
    loading.value = true;
    List<Address> list = await GeneralRepo().getAddressList();
    addressList.clear();
    addressList.addAll(list);
    loading.value = false;
    if (addressList.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    update();
  }

  addAddress(Address address) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    address.id = id.toString();
    await GeneralRepo().addAddress(address);
    getAddressList();
  }
}
