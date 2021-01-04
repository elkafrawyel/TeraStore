import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_outlined_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';

class ReviewsTab extends StatelessWidget {
  final ProductModel product;

  ReviewsTab({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: kDefaultPadding,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: kDefaultPadding, end: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ratingView(),
                CustomOutLinedButton(
                  text: 'addComment'.tr,
                  colorText: Get.find<MainController>().primaryColor,
                  onPressed: () {
                    _buildRatingDialog();
                  },
                  borderColor: Get.find<MainController>().primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          _reviewsList()
        ],
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
            content: Container(
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
                        hintText: "Add Review",
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
                            .showMessage('Rating', 'Please choose stars');
                      } else if (reviewText == null || reviewText.isEmpty) {
                        CommonMethods()
                            .showMessage('Rating', 'Please type some words');
                      } else {
                        Get.back();
                        CommonMethods().showMessage(
                            'Rating', 'Thanks for giving us $ratingValue star');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Get.find<MainController>().primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Rate Product",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
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
              initialRating: 3.5,
              isHalfAllowed: true,
              size: 20,
              filledColor: Colors.amber,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
            ),
            SizedBox(
              height: 5,
            ),
            CustomText(
              text: '1253 ${'reviews'.tr}',
              fontSize: 12,
              alignment: AlignmentDirectional.center,
              color: Colors.grey.shade600,
            )
          ],
        ),
      ],
    );
  }

  _reviewsList() {
    return Container(
      height: MediaQuery.of(Get.context).size.height /2,
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: 100,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return CustomText(
            text: 'Review $index',
            fontSize: 20,
          );
        },
      ),
    );
  }
}
