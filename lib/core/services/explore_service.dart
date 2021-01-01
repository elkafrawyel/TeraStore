import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreService {
  final CollectionReference _slidersRef =
  FirebaseFirestore.instance.collection('sliders');

  final CollectionReference _categoriesRef =
      FirebaseFirestore.instance.collection('Categories');

  final CollectionReference _productsRef =
  FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getSliders() async {
    var value =await _slidersRef.get();
    return value.docs;
  }
  Future<List<QueryDocumentSnapshot>> getCategories() async {
    var value =await _categoriesRef.get();
    return value.docs;
  }
  Future<List<QueryDocumentSnapshot>> getBestSellingProducts() async {
    var value =await _productsRef.get();
    return value.docs;
  }
}
