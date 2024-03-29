import 'package:flutter/material.dart';
import 'package:tera/a_storage/local_storage.dart';

// ================ values =========================
const kDefaultPadding = 20.0;
const fontSizeSmall_16 = 16.0;
const fontSizeBig_18 = 18.0;
const fontSizeLarge_20 = 20.0;
const iconSize = 30;
// const currency = 'EGP';
// list of colors that we use in our app
const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);
const kCardColor = Color(0xF0F0F0F0);

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);
// ================ images ========================
const placeholder = 'src/images/placeholder.jpg';
const logo = 'src/images/logo.png';
const errorImage = 'src/json/error.json';
const loadingImage = 'src/json/loading.json';
const noNetworkImage = 'src/json/no_internet.json';
const emptyImageFace = 'src/json/empty.json';
const emptyImageMagnifier = 'src/json/empty_magnifier.json';
const emptyImageBox = 'src/json/empty_box.json';
const newImage = 'src/images/Icon_New.png';
const facebookImage = 'src/images/facebook.png';
const twitterImage = 'src/images/twitter.png';
const googleImage = 'src/images/google.png';
const deleteImage = 'src/images/Icon_Delete.png';

// ================ Strings ========================
const defaultImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/ecommerce-43b02.appspot.com/o/DefaultImages%2FAvatar.png?alt=media&token=ab2a22a6-43f5-47f7-8638-c6892e03292f';

//=========================================================
class Constants {
  static final Color backgroundColor = Colors.grey.shade200;
  static final Color appBarTextColor = Colors.white;
  static final double appBarHeight = 50;
}

enum ProductFilters {
  Latest,
  HighPrice,
  LowPrice,
  HighRate,
  Range,
}

extension ProductFiltersExtension on ProductFilters {
  String get value {
    switch (this) {
      case ProductFilters.HighPrice:
        return 'highPrice';
      case ProductFilters.LowPrice:
        return 'lowPrice';
      case ProductFilters.Latest:
        return 'latest';
      case ProductFilters.HighRate:
        return 'highRate';
      case ProductFilters.Range:
        return 'range';
    }
    return 'highPrice';
  }

  String get text {
    switch (this) {
      case ProductFilters.HighPrice:
        return LocalStorage().isArabicLanguage() ? 'الاعلي سعرا' : 'High Price';
      case ProductFilters.LowPrice:
        return LocalStorage().isArabicLanguage() ? 'الاقل سعرا' : 'Low Price';
      case ProductFilters.Latest:
        return LocalStorage().isArabicLanguage()
            ? 'احدث المنتجات'
            : 'Latest Arrived';
      case ProductFilters.HighRate:
        return LocalStorage().isArabicLanguage()
            ? 'الاعلي تقييما'
            : 'High Rate';
      case ProductFilters.Range:
        return LocalStorage().isArabicLanguage() ? 'السعر' : 'Price';
        break;
    }
    return LocalStorage().isArabicLanguage() ? 'الاعلي سعرا' : 'High Price';
  }
}
