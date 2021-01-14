class AddAddressRequest {
  String title, governorate, city, completeAdress;

  AddAddressRequest({
    this.title,
    this.governorate,
    this.city,
    this.completeAdress,
  });

  AddAddressRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    governorate = json['governorate'];
    city = json['city'];
    completeAdress = json['completeAdress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['governorate'] = this.governorate;
    data['city'] = this.city;
    data['completeAdress'] = this.completeAdress;
    return data;
  }
}
