import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/a_repositories/review_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/requests/add_review_request.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/data/responses/reviews_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';

class ProductDetailsController extends MainController {
  ProductDetailsResponse productDetailsResponse;
  int selectedTab = 0;

  List<ProductModel> similarProducts = [];
  ReviewsResponse reviewsResponse;
  List<ReviewModel> reviews = [];

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
    similarProducts.clear();
    reviews.clear();
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
    ReviewRepo().getReviewsList(
      productId,
      state: (dataResource) {
        if (dataResource is Success) {
          reviewsResponse = dataResource.data as ReviewsResponse;
          reviews.addAll(reviewsResponse.usersItemComment);
          empty.value = reviews.isEmpty;
          update();
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr);
        }
      },
    );
  }

  addReview(String productId, String reviewText, double ratingValue) async {
    ReviewRepo().addReview(
      AddReviewRequest(
          productId: productId,
          comment: reviewText,
          rate: ratingValue.toString()),
      state: (dataResource) {
        if (dataResource is Success) {
          getReviewsList(productId);
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar(dataResource.errorMessage);
        }
      },
    );
  }
}
