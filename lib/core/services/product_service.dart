import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductService {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getProducts(String subCategoryId) async {
    Query query = _productsRef.where('subCategoryId', isEqualTo: subCategoryId);
    var value = await query.get();

    return value.docs;
  }

  addProduct(ProductModel productModel, PickedFile selectedImage,
      Function(bool finish) callback) {
    //upload image
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('ProductsImages/${productModel.id}');
    reference.putFile(File(selectedImage.path)).then((value) {
      reference.getDownloadURL().then((url) {
        print(url);
        productModel.image = url;
        _productsRef
            .doc(productModel.id)
            .set(productModel.toJson())
            .then((value) {
          callback(true);
        });
      });
    });
  }

  Future<List<QueryDocumentSnapshot>> getMyProducts() async {
    Query query = _productsRef.where('userId',
        isEqualTo: FirebaseAuth.instance.currentUser.uid);
    var value = await query.get();
    return value.docs;
  }
}
