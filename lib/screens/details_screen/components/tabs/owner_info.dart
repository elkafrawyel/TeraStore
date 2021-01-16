import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'file:///F:/Apps/My%20Flutter%20Apps/TeraStore/lib/data/models/product_model.dart';

class OwnerInfo extends StatelessWidget {
  final ProductModel productModel;

  OwnerInfo({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 10, end: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomText(
                            text: 'productModel.owner.name',
                            color: Colors.black,
                            alignment: AlignmentDirectional.topStart,
                            fontSize: 18,
                          ),
                          CustomText(
                            text: 'owner.email',
                            color: Colors.grey.shade500,
                            alignment: AlignmentDirectional.topStart,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // var phone = productModel.owner.phone;
                            // _launchCaller(phone);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.call,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.message,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchCaller(String phone) async {
    phone == null
        ? CommonMethods().showSnackBar('userHaveNoPhone'.tr)
        : await canLaunch("tel:$phone")
            ? await launch("tel:$phone")
            : throw 'Could not launch ${"tel:$phone"}';
  }
}
