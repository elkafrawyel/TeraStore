import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/model/address_model.dart';
import 'package:get/get.dart';

class GeneralService {
  final CollectionReference _addressRef =
      Firestore.instance.collection('ShippingAddress');

  Future<List<Address>> getAddressList() async {
    DocumentSnapshot snapshot =
        await _addressRef.document(Get.find<MainController>().user.id).get();
    if (snapshot.exists) {
      AddressModel addressModel = AddressModel.fromJson(snapshot.data);
      if (addressModel != null &&
          addressModel.addressList != null &&
          addressModel.addressList.isNotEmpty) {
        print('review list => ${addressModel.addressList.length}');
        return addressModel.addressList;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<void> addAddress(Address address) async {
    List<Address> list = await getAddressList();
    list.add(address);
    AddressModel addressModel = AddressModel(addressList: list);
    await _addressRef
        .document(Get.find<MainController>().user.id)
        .setData(addressModel.toJson());
  }
}
