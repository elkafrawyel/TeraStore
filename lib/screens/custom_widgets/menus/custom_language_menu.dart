import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/helper/language/language_model.dart';

class CustomLanguageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => DropdownButton<LanguageData>(
        iconSize: 20,
        onChanged: (LanguageData language) {
          controller.changeLanguage(language.languageCode);
          Get.updateLocale(Locale(language.languageCode));
        },
        value: controller.getSelectedLanguage(),
        items: controller.languageList
            .map<DropdownMenuItem<LanguageData>>(
              (lang) => DropdownMenuItem<LanguageData>(
                value: lang,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      lang.flag,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      lang.name,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
