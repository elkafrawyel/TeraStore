import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/a_repositories/review_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/model/review_model.dart';

class ProductDetailsController extends MainController {
  ProductDetailsResponse productDetailsResponse;
  int selectedTab = 0;

  List<ProductModel> similarProducts = [];
  List<Review> reviews = [];

  updateSelectedTab(int index) {
    selectedTab = index;
    update();
  }

  updatePropertySelection(ItemProperity main, ItemPropPlus sub) {
    main.itemPropPlus[main.itemPropPlus.indexOf(sub)].isSelected =
        !main.itemPropPlus[main.itemPropPlus.indexOf(sub)].isSelected;
    for (ItemPropPlus subProperity in main.itemPropPlus) {
      if (subProperity != sub) subProperity.isSelected = false;
    }
    update();
  }

  Future<void> getProductById(String productId) async {
    loading.value = true;
    update();
    ProductRepo().getSingleProduct(
      productId,
      state: (dataResource) {
        if (dataResource is Success) {
          loading.value = false;
          update();
          productDetailsResponse = dataResource.data as ProductDetailsResponse;
          similarProducts.addAll(productDetailsResponse.similarItems);
          getReviewsList(productId);
        } else if (dataResource is Failure) {
          loading.value = false;
          update();
          CommonMethods().showSnackBar('error'.tr);
        }
      },
    );
  }

  getReviewsList(String productId) async {
    reviews.clear();

    List<Review> list = await ReviewRepo().getReviewsList(productId);
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
