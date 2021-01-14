// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/model/product_model.dart';
import 'package:tera/model/sub_category_model.dart';

class ProductsController extends MainController {
  ValueNotifier<bool> loadingSubCategories = ValueNotifier(false);
  ValueNotifier<bool> emptySubCategories = ValueNotifier(false);

  int selectedSubCategoryIndex = 0;
  List<SubCategoryModel> _subCategories = [];

  List<SubCategoryModel> get subCategories => _subCategories;

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  getSubCategories(String categoryId) async {
    loadingSubCategories.value = true;
    _subCategories.clear();
    // List<DocumentSnapshot> list =
    //     await CategoryRepo().getSubCategories(categoryId);
    //
    // list.forEach((element) {
    //   SubCategoryModel subCategoryModel =
    //       SubCategoryModel.fromJson(element.data);
    //   subCategoryModel.id = element.documentID;
    //   _subCategories.add(subCategoryModel);
    // });
    if (_subCategories.isEmpty) {
      emptySubCategories.value = true;
      empty.value = true;
    } else {
      emptySubCategories.value = false;
      //load products of first subCategory
      Get.find<ProductsController>().getProducts();
    }
    loadingSubCategories.value = false;
    print('SubCategories count => ${_subCategories.length}');
    update();
  }

  getProducts() async {
    loading.value = true;
    update();
    _products.clear();
    String id = _subCategories[selectedSubCategoryIndex].id;

    // List<DocumentSnapshot> list = await ProductRepo().getProducts(id);

    // list.forEach((element) {
    //   ProductModel productModel = ProductModel.fromJson(element.data);
    //   productModel.id = element.documentID;
    //   _products.add(productModel);
    //   print('Product model => $productModel');
    // });
    loading.value = false;
    if (_products.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    print('Products Size => ${_products.length}');
    update();
  }
}
