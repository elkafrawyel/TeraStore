import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/review_model.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/empty_view.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rating_bar/rating_bar.dart';

class ReviewsTab extends StatelessWidget {
  final ProductModel product;
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
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
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
                        maxLines: 8,
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
                              product.id, reviewText, ratingValue);
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
              initialRating: _calculateRating(),
              isHalfAllowed: true,
              size: 25,
              filledColor: Colors.amber,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            CustomText(
              text: '(${controller.reviews.length})',
              fontSize: 16,
              alignment: AlignmentDirectional.center,
              color: Colors.grey.shade600,
            )
          ],
        ),
      ],
    );
  }

  _reviewsList() {
    return _reviews();
  }

  List<Widget> _reviews() {
    List<Widget> widgets = [];
    widgets.add(
      SizedBox(
        height: kDefaultPadding,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: LocalStorage().primaryColor(),
              ),
              alignment: AlignmentDirectional.center,
              child: IconButton(
                  alignment: AlignmentDirectional.center,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _buildRatingDialog();
                  }),
            ),
          ],
        ),
      ),
    );
    widgets.add(
      SizedBox(
        height: kDefaultPadding,
      ),
    );
    controller.reviews.length == 0
        ? widgets.add(
            EmptyView(
              textColor: Colors.black,
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
                      backgroundImage: NetworkImage(controller
                          .reviews[controller.reviews.indexOf(element)]
                          .userImage),
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
                            text: controller
                                .reviews[controller.reviews.indexOf(element)]
                                .message,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.readOnly(
                              initialRating: controller
                                  .reviews[controller.reviews.indexOf(element)]
                                  .rate,
                              isHalfAllowed: true,
                              size: 25,
                              filledColor: Colors.amber,
                              halfFilledIcon: Icons.star_half,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
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
                                text: _buildText(
                                    controller.reviews.indexOf(element)),
                                fontSize: 14,
                                color: Colors.grey.shade700,
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

  _buildText(int index) {
    String name = controller.reviews[index].userName;
    int time = controller.reviews[index].time;
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

  double _calculateRating() {
    int oneStar = 0;
    int twoStar = 0;
    int threeStar = 0;
    int fourStar = 0;
    int fiveStar = 0;
    if (controller.reviews.isEmpty) return 0;
    for (Review review in controller.reviews) {
      if (review.rate == 5) {
        fiveStar++;
      } else if (review.rate == 4) {
        fourStar++;
      } else if (review.rate == 3) {
        threeStar++;
      } else if (review.rate == 2) {
        twoStar++;
      } else {
        oneStar++;
      }
    }
    double rate = (5 * fiveStar +
            4 * fourStar +
            3 * threeStar +
            2 * twoStar +
            1 * oneStar) /
        (fiveStar + fourStar + threeStar + twoStar + oneStar);

    return rate;
  }
}
