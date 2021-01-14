import 'package:tera/data/models/address_model.dart';

class AddressesResponse {
  bool status;
  String message;
  List<AddressModel> data;

  AddressesResponse({this.status, this.message, this.data});

  AddressesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<AddressModel>();
      json['data'].forEach((v) {
        data.add(new AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
