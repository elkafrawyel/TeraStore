import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_description_text.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/details_screen/components/tabs/owner_info.dart';

class InfoTab extends StatelessWidget {
  final SingleItem product;

  InfoTab({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LocalStorage().primaryColor(),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 4),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
                    child: CustomText(
                      text: 'description'.tr,
                      fontSize: 18,
                      // color: Colors.white,
                      alignment: AlignmentDirectional.centerStart,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: kDefaultPadding, end: kDefaultPadding),
                    child: CustomDescription(
                      text: product.itemDescribe,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding / 4),
            OwnerInfo(
              user: product.user,
            ),
            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
