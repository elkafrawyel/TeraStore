import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_description_text.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';

import 'owner_info.dart';

class InfoTab extends StatelessWidget {
  final ProductModel product;

  InfoTab({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: CustomText(
                text: 'description'.tr,
                fontSize: 18,
                alignment: AlignmentDirectional.centerStart,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: kDefaultPadding, end: kDefaultPadding),
              child: CustomDescription(
                text: product.description,
              ),
            ),
            SizedBox(height: kDefaultPadding),
            product.owner == null
                ? Container()
                : OwnerInfo(
                    owner: product.owner,
                  ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
