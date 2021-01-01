import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user_model.dart';

class UserService {

  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.id)
        .set(userModel.toJson());
  }

  Future<List<QueryDocumentSnapshot>> getUser(String userId) async {
    Query query = _userCollectionRef.where('id', isEqualTo: userId);
    var value = await query.get();
    return value.docs;
  }
}
