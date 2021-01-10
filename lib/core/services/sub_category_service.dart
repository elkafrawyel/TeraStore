import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryService {
  final CollectionReference _categoriesRef =
      Firestore.instance.collection('SubCategories');

  Future<List<DocumentSnapshot>> getSubCategories(String categoryId) async {
    Query query = _categoriesRef.where('categoryId', isEqualTo: categoryId);
    var value = await query.getDocuments();

    return value.documents;
  }
}
