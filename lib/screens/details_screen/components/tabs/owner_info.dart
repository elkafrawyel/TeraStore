import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerInfo extends StatelessWidget {
  final UserModel user;

  OwnerInfo({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomText(
                            text: 'sellerInfo'.tr,
                            color: Colors.black,
                            alignment: AlignmentDirectional.topStart,
                            fontSize: fontSizeSmall_16,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          CustomText(
                            text: user == null
                                ? 'productModel.owner.name'
                                : user.name,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            alignment: AlignmentDirectional.topStart,
                            fontSize: fontSizeSmall_16 - 2,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          CustomText(
                            text: user == null
                                ? 'productModel.owner.name'
                                : user.email,
                            color: Colors.grey.shade700,
                            alignment: AlignmentDirectional.topStart,
                            fontSize: fontSizeSmall_16 - 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            var phone = user == null ? null : user.phone;
                            _launchCaller(phone);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.call,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.message,
                              color: Colors.green,
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
