import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryService {
  final CollectionReference _categoriesRef =
      FirebaseFirestore.instance.collection('SubCategories');

  Future<List<QueryDocumentSnapshot>> getSubCategories(
      String categoryId) async {
    Query query = _categoriesRef.where('categoryId', isEqualTo: categoryId);
    var value = await query.get();

    return value.docs;
  }
}
