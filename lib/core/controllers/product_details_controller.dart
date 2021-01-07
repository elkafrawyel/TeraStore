import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/review_service.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/review_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends MainController {
  ProductModel productModel;
  int selectedTab = 0;

  List<ProductModel> similarProducts = [];
  List<Review> reviews = [];

  updateSelectedTab(int index) {
    selectedTab = index;
    update();
  }

  Future<void> getProductById(String productId) async {
    loading.value = true;
    update();
    DocumentSnapshot snapshot =
        await ProductService().getProductById(productId);
    if (snapshot.exists) {
      productModel = ProductModel.fromJson(snapshot.data());
      //get product owner
      DocumentSnapshot userSnapShot =
          await UserService().getUser(productModel.userId);
      UserModel owner = UserModel.fromJson(userSnapShot.data());
      productModel.owner = owner;
      //check if is favourite
      await checkIfFavourite(productId);
      if (productModel != null && productModel.owner != null) {
        loading.value = false;
        update();
      } else {
        loading.value = true;
        update();
      }

      getSimilarProducts(productModel.subCategoryId, productModel.id);
      getReviewsList(productId);
    }
  }

  Future<void> checkIfFavourite(String productId) async {
    await ProductService().checkIfFavourite(productId, (isFave) {
      productModel.isFav = isFave;
    });
  }

  addToFavourites(String productId) async {
    await ProductService().addToFavourites(productId);
    productModel.isFav = true;
    CommonMethods().showMessage(productModel.name, 'addedToFavourite'.tr);
    update();
  }

  removeFromFavourites(String productId) async {
    await ProductService().removeFromFavourites(productId);
    productModel.isFav = false;
    CommonMethods().showMessage(productModel.name, 'removedFromFavourite'.tr);
    update();
  }

  getSimilarProducts(String subCategoryId, String productId) async {
    similarProducts.clear();
    List<QueryDocumentSnapshot> list =
        await ProductService().getSimilarProducts(subCategoryId, productId);
    list.forEach((element) {
      ProductModel productModel = ProductModel.fromJson(element.data());
      if (productId == element.id) return;
      productModel.id = element.id;
      similarProducts.add(productModel);
      print('Product model => $productModel');
    });
    if (similarProducts.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    print('Products Size => ${similarProducts.length}');
    update();
  }

  getReviewsList(String productId) async {
    List<Review> list = await ReviewService().getReviewsList(productId);
    reviews.clear();
    reviews.addAll(list);
    if (reviews.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    update();
  }

  addReview(String productId, String reviewText, double ratingValue) async {
    int id = DateTime.now().millisecondsSinceEpoch;

    await ReviewService().addReview(
        productId,
        Review(
            id: id.toString(),
            rate: ratingValue,
            time: id,
            message: reviewText,
            userImage: Get.find<MainController>().user.photo,
            userName: Get.find<MainController>().user.name));
    getReviewsList(productId);
  }
}
