import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user_model.dart';

class UserRepo {
  //login , register, edit, verify, logOut,

  Future<void> addUserToFireStore(UserModel userModel) async {}

  Future<DocumentSnapshot> getUser(String userId) async {
    return null;
  }
}
