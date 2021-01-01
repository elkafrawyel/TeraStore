class UserModel {
  String id, email, name, photo;

  UserModel({this.id, this.email, this.name, this.photo});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;

    id = map['id'];
    email = map['email'];
    name = map['name'];
    photo = map['photo'];
  }

  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
    };
  }

  @override
  String toString() {
    return 'userId : $id - name : $name - email : $email - image : $photo ';
  }
}
