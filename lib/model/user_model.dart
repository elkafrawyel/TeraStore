class UserModel {
  String id, email, name, photo, phone, location;

  UserModel(
      {this.id, this.email, this.name, this.photo, this.phone, this.location});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;

    id = map['id'];
    email = map['email'];
    name = map['name'];
    photo = map['photo'];
    phone = map['phone'];
    location = map['location'];
  }

  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
      'photo': photo,
    };
  }

  @override
  String toString() {
    return 'userId : $id - name : $name - email : $email - image : $photo ';
  }
}
