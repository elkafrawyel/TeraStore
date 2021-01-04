import 'package:flutter/material.dart';

// ================ values =========================
const kDefaultPadding = 20.0;

// list of colors that we use in our app
const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);

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
const emptyImageBox = 'src/json/empty_box.json';
const newImage = 'src/images/Icon_New.png';
const facebookImage = 'src/images/facebook.png';
const googleImage = 'src/images/google.png';
const exploreImage = 'src/images/Icon_Explore.png';
const cartImage = 'src/images/Icon_Cart.png';
const accountImage = 'src/images/Icon_User.png';
const editProfileImage = 'src/images/edit_profile.png';
const locationImage = 'src/images/Icon_Location.png';
const historyImage = 'src/images/Icon_History.png';
const cardsImage = 'src/images/Icon_Payment.png';
const notificationImage = 'src/images/Icon_Alert.png';
const logOutImage = 'src/images/Icon_Exit.png';

// ================ Strings ========================
const defaultImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/ecommerce-43b02.appspot.com/o/DefaultImages%2FAvatar.png?alt=media&token=ab2a22a6-43f5-47f7-8638-c6892e03292f';

class Constants {
  static final Color backgroundColor = Colors.grey.shade200;
  static final Color appBarTextColor = Colors.white;
  static final double appBarHeight = 50;
}
