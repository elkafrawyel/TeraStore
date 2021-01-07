import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/review_model.dart';

class ReviewService {
  final CollectionReference _reviewsRef =
      FirebaseFirestore.instance.collection('Reviews');

  Future<List<Review>> getReviewsList(String productId) async {
    DocumentSnapshot snapshot = await _reviewsRef.doc(productId).get();
    if (snapshot.exists) {
      ReviewModel reviewModel = ReviewModel.fromJson(snapshot.data());
      if (reviewModel != null &&
          reviewModel.reviews != null &&
          reviewModel.reviews.isNotEmpty) {
        print('review list => ${reviewModel.reviews.length}');
        return reviewModel.reviews;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<void> addReview(String productId, Review review) async {
    List<Review> reviews = await getReviewsList(productId);
    reviews.add(review);
    ReviewModel reviewModel = ReviewModel(reviews: reviews);
    await _reviewsRef.doc(productId).set(reviewModel.toJson());
  }
}
