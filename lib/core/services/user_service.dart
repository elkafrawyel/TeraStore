import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user_model.dart';

class UserService {
  final CollectionReference _userCollectionRef =
      Firestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .document(userModel.id)
        .setData(userModel.toJson());
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    DocumentSnapshot snapshot = await _userCollectionRef.document(userId).get();
    return snapshot;
  }
}
