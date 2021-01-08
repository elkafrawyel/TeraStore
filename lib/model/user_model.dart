class UserModel {
  String id, email, name, photo, phone;
  bool phoneVerified;

  UserModel(
      {this.id,
      this.email,
      this.name,
      this.photo,
      this.phone,
      this.phoneVerified});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;

    id = map['id'];
    email = map['email'];
    name = map['name'];
    photo = map['photo'];
    phone = map['phone'];
    phoneVerified = map['phoneVerified'];
  }

  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'photo': photo,
      'phoneVerified': phoneVerified,
    };
  }

  @override
  String toString() {
    return 'userId : $id - name : $name';
  }
}
