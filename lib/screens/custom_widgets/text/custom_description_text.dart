import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

class CustomDescription extends StatefulWidget {
  final String text;

  CustomDescription({this.text});

  @override
  _CustomDescriptionState createState() => _CustomDescriptionState();
}

class _CustomDescriptionState extends State<CustomDescription> {
  bool isSeeMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text,
              style: TextStyle(fontSize: 16),
              maxLines: isSeeMore ? 20 : 4,
              textAlign: TextAlign.start),
          GestureDetector(
            onTap: () {
              setState(() {
                isSeeMore = !isSeeMore;
              });
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    isSeeMore
                        ? Text(
                            "Show Less",
                            style: TextStyle(
                              color: LocalStorage().primaryColor(),
                              fontSize: 14,
                            ),
                          )
                        : Text("Show More",
                            style: TextStyle(
                                color: LocalStorage().primaryColor(), fontSize: 14))
                  ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
