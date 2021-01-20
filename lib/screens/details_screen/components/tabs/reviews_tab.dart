import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/product_details_controller.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/data/responses/reviews_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class ReviewsTab extends StatelessWidget {
  final SingleItem product;
  final controller = Get.find<ProductDetailsController>();

  ReviewsTab({this.product}) {
    if (LocalStorage().isArabicLanguage())
      initializeDateFormatting("ar_SA", null);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      builder: (controller) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _reviewsList(),
        ),
      ),
    );
  }

  _buildRatingDialog() {
    double ratingValue;
    String reviewText;
    showDialog(
        context: Get.context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: SingleChildScrollView(
              child: Container(
                width: 1000.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    RatingBar(
                      onRatingChanged: (rating) {
                        ratingValue = rating;
                      },
                      initialRating: 0,
                      isHalfAllowed: true,
                      size: 40,
                      halfFilledColor: Colors.amber,
                      maxRating: 5,
                      filledColor: Colors.amber,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: TextField(
                        onChanged: (value) {
                          reviewText = value;
                        },
                        decoration: InputDecoration(
                          hintText: "addReview".tr,
                          hintStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        maxLines: 6,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (ratingValue == null) {
                          CommonMethods()
                              .showMessage('rate'.tr, 'chooseStars'.tr);
                        } else if (reviewText == null || reviewText.isEmpty) {
                          CommonMethods()
                              .showMessage('rate'.tr, 'typeWords'.tr);
                        } else {
                          Get.back();
                          controller.addReview(
                              product.id.toString(), reviewText, ratingValue);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: LocalStorage().primaryColor(),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          'rateProduct'.tr,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _ratingView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            RatingBar.readOnly(
              initialRating: double.parse(
                  controller.reviewsResponse.productRate.toString()),
              isHalfAllowed: true,
              size: 20,
              filledColor: Colors.amber,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              halfFilledColor: Colors.white,
              emptyColor: Colors.white,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            CustomText(
              text: '(${controller.reviews.length})',
              fontSize: fontSizeSmall_16,
              alignment: AlignmentDirectional.center,
              color: Colors.white,
            )
          ],
        ),
      ],
    );
  }

  List<Widget> _reviewsList() {
    List<Widget> widgets = [];
    widgets.add(
      SizedBox(
        height: kDefaultPadding / 2,
      ),
    );
    widgets.add(
      Padding(
        padding: EdgeInsetsDirectional.only(
            start: kDefaultPadding, end: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ratingView(),
            Container(
              height: 40,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white)),
                color: LocalStorage().primaryColor().withOpacity(0.7),
                onPressed: () {
                  _buildRatingDialog();
                },
                icon: Icon(
                  Icons.add_comment,
                  color: Colors.white,
                ),
                label: CustomText(
                  text: 'addReview'.tr,
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                  fontSize: fontSizeSmall_16 - 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Divider(
          height: 1,
          color: Colors.white,
        ),
      ),
    );
    controller.reviews.length == 0
        ? widgets.add(
            EmptyView(
              textColor: Colors.white,
              message: 'noReviews'.tr,
            ),
          )
        : controller.reviews.forEach((element) {
            widgets.add(Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: kDefaultPadding / 2,
                  end: kDefaultPadding / 2,
                  bottom: kDefaultPadding),
              child: Row(
                children: [
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          element.user.image == null ? '' : element.user.image),
                      radius: 50,
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            alignment: AlignmentDirectional.centerStart,
                            text: element.comment,
                            fontSize: fontSizeSmall_16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.readOnly(
                              initialRating:
                                  double.parse(element.rate.toString()),
                              isHalfAllowed: true,
                              size: 20,
                              filledColor: Colors.amber,
                              halfFilledIcon: Icons.star_half,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledColor: Colors.white,
                              emptyColor: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomText(
                                alignment: AlignmentDirectional.topStart,
                                text: _buildText(element),
                                fontSize: fontSizeSmall_16 - 2,
                                color: Colors.white,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
          });
    widgets.add(
      SizedBox(
        height: kDefaultPadding,
      ),
    );
    return widgets;
  }

  _buildText(ReviewModel element) {
    String name = element.user.name;
    int time = element.unixTime;
    return '${'by'.tr} $name \n${'on'.tr} ${_getDateString(time)}';
  }

  String _getDateString(int time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    if (LocalStorage().isArabicLanguage()) {
      var formatter = DateFormat.yMMMMEEEEd('ar_SA');
      print(formatter.locale);
      String formatted = formatter.format(date);
      print(formatted);
      return formatted;
    } else {
      var formatter = DateFormat.yMMMMEEEEd();
      print(formatter.locale);
      String formatted = formatter.format(date);
      print(formatted);
      return formatted;
    }
  }

// double _calculateRating() {
//   int oneStar = 0;
//   int twoStar = 0;
//   int threeStar = 0;
//   int fourStar = 0;
//   int fiveStar = 0;
//   if (controller.reviews.isEmpty) return 0;
//   for (ReviewModel review in controller.reviews) {
//     if (review.rate == 5) {
//       fiveStar++;
//     } else if (review.rate == 4) {
//       fourStar++;
//     } else if (review.rate == 3) {
//       threeStar++;
//     } else if (review.rate == 2) {
//       twoStar++;
//     } else {
//       oneStar++;
//     }
//   }
//   double rate = (5 * fiveStar +
//           4 * fourStar +
//           3 * threeStar +
//           2 * twoStar +
//           1 * oneStar) /
//       (fiveStar + fourStar + threeStar + twoStar + oneStar);
//
//   return rate;
// }
}
