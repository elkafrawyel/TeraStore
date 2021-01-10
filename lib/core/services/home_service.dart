import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';

class HomeService {
  final CollectionReference _slidersRef =
      Firestore.instance.collection('sliders');

  final CollectionReference _categoriesRef =
      Firestore.instance.collection('Categories');

  final CollectionReference _productsRef =
      Firestore.instance.collection('Products');

  Future<List<DocumentSnapshot>> getSliders() async {
    var value = await _slidersRef.getDocuments();
    return value.documents;
  }

  Future<List<DocumentSnapshot>> getCategories() async {
    var value = await _categoriesRef.getDocuments();
    return value.documents;
  }

  //get products in same subCategory
  Future<List<DocumentSnapshot>> searchProducts(String searchText) async {
    Query query = _productsRef
        .orderBy('name')
        .startAt([searchText]).endAt([searchText + '\uf8ff']);
    var value = await query.getDocuments();

    return value.documents;
  }

  Future<List<DocumentSnapshot>> getSliderProducts() async {
    Query query = _productsRef.limit(5);
    var value = await query.getDocuments();
    return value.documents;
  }

  Future<List<DocumentSnapshot>> getFilteredProducts(
      ProductFilters filter) async {
    switch (filter) {
      case ProductFilters.HighPrice:
        return await _highPriceFilter();
      case ProductFilters.LowPrice:
        return await _lowPriceFilter();
      case ProductFilters.Latest:
        print('Todo work');
        return _latestFilter();
      // case ProductFilters.LowRate:
      //   print('Todo work');
      //   return [];
    }
    return await _highPriceFilter();
  }

  Future<List<DocumentSnapshot>> _highPriceFilter() async {
    Query query = _productsRef.orderBy('discountPrice', descending: true);
    var value = await query.getDocuments();
    return value.documents;
  }

  Future<List<DocumentSnapshot>> _lowPriceFilter() async {
    Query query = _productsRef.orderBy('discountPrice', descending: false);
    var value = await query.getDocuments();
    return value.documents;
  }

  Future<List<DocumentSnapshot>> _latestFilter() async {
    Query query = _productsRef.orderBy('id', descending: true);
    var value = await query.getDocuments();
    return value.documents;
  }
}
