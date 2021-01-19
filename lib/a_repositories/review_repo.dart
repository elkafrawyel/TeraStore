import 'package:tera/a_storage/network/products/products_service.dart';
import 'package:tera/data/requests/add_review_request.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/reviews_response.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';

class ReviewRepo {
  getReviewsList(String productId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.getProductReviews(productId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ReviewsResponse reviewsResponse =
              ReviewsResponse.fromJson(response.body);
          if (reviewsResponse.status) {
            state(Success(data: reviewsResponse));
          } else {
            state(Failure(errorMessage: 'Failed to get Reviews'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get Reviews'));
        }
      },
    );
  }

  Future<void> addReview(AddReviewRequest addReviewRequest,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.addReview(addReviewRequest),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            state(Success());
          } else {
            state(Failure(errorMessage: 'Failed to get Reviews'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get Reviews'));
        }
      },
    );
  }
}
