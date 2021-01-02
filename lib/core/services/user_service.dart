import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user_model.dart';

class UserService {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef.doc(userModel.id).set(userModel.toJson());
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    DocumentSnapshot snapshot = await _userCollectionRef.doc(userId).get();
    return snapshot;
  }
}
