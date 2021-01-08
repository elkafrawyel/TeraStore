import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/general_service.dart';
import 'package:flutter_app/model/address_model.dart';

class GeneralController extends MainController {
  List<Address> addressList = [];

  getAddressList() async {
    loading.value = true;
    List<Address> list = await GeneralService().getAddressList();
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
    await GeneralService().addAddress(address);
    getAddressList();
  }
}
