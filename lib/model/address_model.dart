class AddressModel {
  List<Address> addressList;

  AddressModel({this.addressList});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addressList = List<Address>.empty(growable: true);
      json['addresses'].forEach((v) {
        addressList.add(Address.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressList != null) {
      data['addresses'] = this.addressList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String title;
  String body;
  String id;

  Address({this.id, this.title, this.body});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
