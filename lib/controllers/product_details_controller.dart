import 'package:get/get.dart';
import 'package:tera/a_repositories/review_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/model/review_model.dart';

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
    // getSimilarProducts(productModel.subCategoryId, productModel.id.toString());
    // getReviewsList(productId);
  }

  Future<void> checkIfFavourite(String productId) async {
    // await ProductRepo().checkIfFavourite(productId, (isFave) {
    //   productModel.isFav = isFave;
    // });
  }

  addToFavourites(String productId) async {
    // await ProductRepo().addToFavourites(productId);
    // productModel.isFav = true;
    // CommonMethods().showMessage(productModel.name, 'addedToFavourite'.tr);
    // update();
  }

  removeFromFavourites(String productId) async {
    // await ProductRepo().removeFromFavourites(productId);
    // productModel.isFav = false;
    // CommonMethods().showMessage(productModel.name, 'removedFromFavourite'.tr);
    // update();
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
            userImage: Get.find<MainController>().user.image,
            userName: Get.find<MainController>().user.name));
    getReviewsList(productId);
  }
}
