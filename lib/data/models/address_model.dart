class AddressModel {
  String title;
  String governorate;
  String city;
  String completeAdress;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  AddressModel(
      {this.title,
      this.governorate,
      this.city,
      this.completeAdress,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    governorate = json['governorate'];
    city = json['city'];
    completeAdress = json['completeAdress'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['governorate'] = this.governorate;
    data['city'] = this.city;
    data['completeAdress'] = this.completeAdress;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
