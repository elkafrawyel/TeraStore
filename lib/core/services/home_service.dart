import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';

class HomeService {
  final CollectionReference _slidersRef =
      FirebaseFirestore.instance.collection('sliders');

  final CollectionReference _categoriesRef =
      FirebaseFirestore.instance.collection('Categories');

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getSliders() async {
    var value = await _slidersRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getCategories() async {
    var value = await _categoriesRef.get();
    return value.docs;
  }

  //get products in same subCategory
  Future<List<QueryDocumentSnapshot>> searchProducts(String searchText) async {
    Query query = _productsRef
        .orderBy('name')
        .startAt([searchText]).endAt([searchText + '\uf8ff']);
    var value = await query.get();

    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getSliderProducts() async {
    Query query = _productsRef.limit(5);
    var value = await query.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getFilteredProducts(
      ProductFilters filter) async {
    switch (filter) {
      case ProductFilters.HighPrice:
        return await _highPriceFilter();
      case ProductFilters.LowPrice:
        return await _lowPriceFilter();
      case ProductFilters.HighRate:
        print('Todo work');
        return [];
      case ProductFilters.LowRate:
        print('Todo work');
        return [];
    }
    return await _highPriceFilter();
  }

  Future<List<QueryDocumentSnapshot>> _highPriceFilter() async {
    Query query = _productsRef.orderBy('discountPrice', descending: true);
    var value = await query.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> _lowPriceFilter() async {
    Query query = _productsRef.orderBy('discountPrice', descending: false);
    var value = await query.get();
    return value.docs;
  }


}
