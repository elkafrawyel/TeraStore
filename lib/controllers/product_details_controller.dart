import 'package:flutter_app/a_repositories/product_repo.dart';
import 'package:flutter_app/a_repositories/review_repo.dart';
import 'package:flutter_app/controllers/main_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/review_model.dart';
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

    loading.value = false;
    update();
    getSimilarProducts(productModel.subCategoryId, productModel.id);
    getReviewsList(productId);
  }

  Future<void> checkIfFavourite(String productId) async {
    await ProductRepo().checkIfFavourite(productId, (isFave) {
      productModel.isFav = isFave;
    });
  }

  addToFavourites(String productId) async {
    await ProductRepo().addToFavourites(productId);
    productModel.isFav = true;
    CommonMethods().showMessage(productModel.name, 'addedToFavourite'.tr);
    update();
  }

  removeFromFavourites(String productId) async {
    await ProductRepo().removeFromFavourites(productId);
    productModel.isFav = false;
    CommonMethods().showMessage(productModel.name, 'removedFromFavourite'.tr);
    update();
  }

  getSimilarProducts(String subCategoryId, String productId) async {
    similarProducts.clear();

    if (similarProducts.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    print('Products Size => ${similarProducts.length}');
    update();
  }

  getReviewsList(String productId) async {
    List<Review> list = await ReviewRepo().getReviewsList(productId);
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

    await ReviewRepo().addReview(
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