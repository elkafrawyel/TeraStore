import 'dart:convert';

class SubProperityModel {
  String name, price;

  SubProperityModel({this.name, this.price});

  SubProperityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
