import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color pickedColor = Get.find<MainController>().primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'settings'.tr,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: kDefaultPadding,
                start: kDefaultPadding,
                end: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'notifications'.tr,
                  fontSize: 20,
                ),
                Switch(
                  value: LocalStorage().getBool(LocalStorage.notifications),
                  onChanged: (value) {
                    LocalStorage().setBool(LocalStorage.notifications, value);
                    setState(() {});
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: kDefaultPadding,
                start: kDefaultPadding,
                end: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'appColor'.tr,
                  fontSize: 18,
                ),
                GestureDetector(
                  onTap: () {
                    _pickColorDialog();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Get.find<MainController>().primaryColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickedColor = color);
  }

  _pickColorDialog() {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('pickColor'.tr),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: pickedColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('change'.tr),
              onPressed: () {
                Navigator.of(context).pop();
                Get.find<MainController>().changeAppColor(pickedColor);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
