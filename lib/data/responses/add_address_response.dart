import 'package:tera/data/models/address_model.dart';

class AddAddressResponse {
  bool status;
  String message;
  AddressModel address;

  AddAddressResponse({this.status, this.message, this.address});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    address =
        json['data'] != null ? new AddressModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.address != null) {
      data['data'] = this.address.toJson();
    }
    return data;
  }
}
