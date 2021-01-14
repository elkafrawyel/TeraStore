class UserModel {
  int id;
  String image;
  String name;
  String email;
  String phone;
  String approved;
  String apiToken;
  String socialType;

  UserModel({
    this.id,
    this.image,
    this.name,
    this.email,
    this.phone,
    this.approved,
    this.apiToken,
    this.socialType,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    approved = json['approved'];
    apiToken = json['api_token'];
    socialType = json['socialType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['approved'] = this.approved;
    data['api_token'] = this.apiToken;
    data['socialType'] = this.socialType;
    return data;
  }

  get photo => image;
}
