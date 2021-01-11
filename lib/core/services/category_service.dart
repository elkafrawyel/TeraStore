import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final CollectionReference _categoriesRef =
      Firestore.instance.collection('Categories');

  final CollectionReference _subCategoriesRef =
      Firestore.instance.collection('SubCategories');

  Future<List<DocumentSnapshot>> getCategories() async {
    var value = await _categoriesRef.getDocuments();
    return value.documents;
  }

  Future<List<DocumentSnapshot>> getSubCategories(String categoryId) async {
    Query query = _subCategoriesRef.where('categoryId', isEqualTo: categoryId);
    var value = await query.getDocuments();

    return value.documents;
  }
}
