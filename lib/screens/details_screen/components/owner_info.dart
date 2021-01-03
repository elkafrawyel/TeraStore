import 'package:flutter/material.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class OwnerInfo extends StatelessWidget {
  final UserModel owner;

  OwnerInfo({this.owner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(owner.photo),
                  radius: 50,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 10),
              child: Column(
                children: [
                  CustomText(
                    text: owner.name,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.message,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          var phone = owner.phone;
                          _launchCaller(phone);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.call,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _launchCaller(String phone) async {
    phone == null
        ? CommonMethods().showMessage('message'.tr, 'userHaveNoPhone'.tr)
        : await canLaunch("tel:$phone")
            ? await launch("tel:$phone")
            : throw 'Could not launch ${"tel:$phone"}';
  }
}
