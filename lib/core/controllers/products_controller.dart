import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/sub_category_service.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/sub_category_model.dart';
import 'package:get/get.dart';

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
    List<QueryDocumentSnapshot> list =
        await SubCategoryService().getSubCategories(categoryId);

    list.forEach((element) {
      SubCategoryModel subCategoryModel =
          SubCategoryModel.fromJson(element.data());
      subCategoryModel.id = element.id;
      _subCategories.add(subCategoryModel);
    });
    if (_subCategories.isEmpty) {
      emptySubCategories.value = true;
      empty.value = true;
    } else {
      emptySubCategories.value = false;
      //load products of first subCategory
      Get.put(ProductsController()).getProducts();
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

    List<QueryDocumentSnapshot> list = await ProductService().getProducts(id);

    list.forEach((element) {
      ProductModel productModel = ProductModel.fromJson(element.data());
      productModel.id = element.id;
      _products.add(productModel);
      print('Product model => $productModel');
    });
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
