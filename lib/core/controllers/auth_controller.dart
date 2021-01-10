import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/graph_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:flutter_app/screens/start_up_screens/auth/verify_phone_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:flutter_app/storage/network/MyService.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends MainController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();
  bool isArabic = LocalStorage().isArabicLanguage();

  signInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      AuthCredential googleAuthCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      AuthResult result =
          await _auth.signInWithCredential(googleAuthCredential);

      String userId = result.user.uid;
      DocumentSnapshot snapshot = await UserService().getUser(userId);
      if (snapshot.exists && snapshot.data != null) {
        user = UserModel.fromJson(snapshot.data);
        user.id = snapshot.documentID;
        LocalStorage().setBool(LocalStorage.loginKey, true);
        LocalStorage().setString(LocalStorage.userId, snapshot.documentID);
        if (user.phone == null) {
          _showGetPhoneDialog();
        } else {
          if (user.phoneVerified) {
            Get.offAll(HomeScreen());
          } else {
            Get.offAll(VerifyPhoneScreen(
              userModel: user,
            ));
          }
        }
      } else {
        user = UserModel(
            id: result.user.uid,
            email: result.user.email,
            name: result.user.displayName,
            photo: result.user.photoUrl,
            phoneVerified: false);

        //showDialog to get phone number
        _showGetPhoneDialog();
      }
    } on AuthResult catch (error) {
      handleError(error);
      print('Failed with error code: $error');
    }
  }

  signInFacebook() async {
    try {
      FacebookLoginResult result = await _facebookLogin.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.error:
          print("Error");
          CommonMethods().showMessage(isArabic ? 'رسالة' : 'Message',
              isArabic ? 'حدث خطأ ما' : 'Error Happened');
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("CancelledByUser");
          CommonMethods().showMessage(isArabic ? 'رسالة' : 'Message',
              isArabic ? 'تم الغاء العملية' : 'CancelledByUser');
          break;
        case FacebookLoginStatus.loggedIn:
          print("LoggedIn");
          final accessToken = result.accessToken.token;
          final facebookAuthCredential =
              FacebookAuthProvider.getCredential(accessToken: accessToken);
          AuthResult authResult =
              await _auth.signInWithCredential(facebookAuthCredential);

          String userId = authResult.user.uid;
          DocumentSnapshot snapshot = await UserService().getUser(userId);

          if (snapshot.exists && snapshot.data != null) {
            user = UserModel.fromJson(snapshot.data);
            user.id = snapshot.documentID;
            LocalStorage().setBool(LocalStorage.loginKey, true);
            LocalStorage().setString(LocalStorage.userId, snapshot.documentID);
            if (user.phone == null) {
              _showGetPhoneDialog();
            } else {
              if (user.phoneVerified) {
                Get.offAll(HomeScreen());
              } else {
                Get.offAll(VerifyPhoneScreen(
                  userModel: user,
                ));
              }
            }
          } else {
            //first time to login in with facebook
            // getting facebook profile photo
            var myService = MyService.create(NetworkBaseUrlType.GraphUrl);
            var response =
                await myService.getFacebookGraph(result.accessToken.token);
            GraphModel graphModel = GraphModel.fromJson(response.body);
            print('response : ' + response.body.toString());
            String photoUrl = graphModel.picture.data.url;
            user = UserModel(
                id: authResult.user.uid,
                email: authResult.user.email,
                name: authResult.user.displayName,
                photo: photoUrl,
                phoneVerified: false);

            //showDialog to get phone number
            _showGetPhoneDialog();
          }

          break;
      }
    } on AuthException catch (e) {
      handleError(e);
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  _showGetPhoneDialog() async {
    TextEditingController controller = TextEditingController();
    showDialog<String>(
      context: Get.context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(
            text: 'enterPhone'.tr,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: new TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  autofocus: true,
                  decoration: new InputDecoration(hintText: 'phone'.tr),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('ok'.tr),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    if (GetUtils.isPhoneNumber(controller.text)) {
                      user.phone = controller.text;
                      saveUser(user);
                      Navigator.pop(context);
                      Get.to(
                        VerifyPhoneScreen(
                          userModel: user,
                        ),
                      );
                    } else {
                      CommonMethods()
                          .showMessage('message'.tr, 'enterValidPhone'.tr);
                    }
                  } else {
                    CommonMethods()
                        .showMessage('message'.tr, 'Enter your phone number');
                  }
                }),
          ],
        );
      },
    );
  }

  signInEmail(String email, String password) async {
    _showGetPhoneDialog();
    // loading.value = true;
    // try {
    //   AuthResult result = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    //   DocumentSnapshot snapshot = await UserService().getUser(result.user.uid);
    //
    //   user = UserModel.fromJson(snapshot.data);
    //   user.id = result.user.uid;
    //   LocalStorage().setBool(LocalStorage.loginKey, true);
    //   LocalStorage().setString(LocalStorage.userId, result.user.uid);
    //
    //   if (user.phoneVerified) {
    //     Get.offAll(HomeScreen());
    //   } else {
    //     Get.offAll(VerifyPhoneScreen(
    //       userModel: user,
    //     ));
    //   }
    // } on AuthException catch (e) {
    //   handleError(e);
    //   print('Failed with error code: ${e.code}');
    //   print(e.message);
    // }
    // loading.value = false;
    // update();
  }

  createAccount(
      String name, String email, String phone, String password) async {
    loading.value = true;
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = UserModel(
          id: result.user.uid,
          email: email,
          name: name,
          photo: defaultImageUrl,
          phone: phone,
          phoneVerified: false);

      saveUser(user);
      LocalStorage().setBool(LocalStorage.loginKey, true);
      LocalStorage().setString(LocalStorage.userId, result.user.uid);
      Get.offAll(
        VerifyPhoneScreen(
          userModel: user,
        ),
      );
    } on AuthException catch (e) {
      handleError(e);
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    loading.value = false;
    update();
  }

  void saveUser(UserModel user) async {
    await UserService().addUserToFireStore(user);
  }

  handleError(error) {
    switch (error.code) {
      case 'account-exists-with-different-credential':
        CommonMethods().showMessage(
            isArabic ? 'خطأ' : 'Error',
            isArabic
                ? 'هذا الايميل موجود بالفعل حاول التسجيل بطريق اخري'
                : 'Account Exists ,Try to login with different method.');
        break;
      case 'user-not-found':
        CommonMethods().showMessage(isArabic ? 'خطأ' : 'Error',
            isArabic ? 'لايوجد مستخدم بهذة البيانات' : 'User not found');
        break;
      case 'email-already-in-use':
        CommonMethods().showMessage(isArabic ? 'خطأ' : 'Error',
            isArabic ? 'الايميل مستخدم بالفعل' : 'email already in use');
        break;
      case 'invalid-email':
        CommonMethods().showMessage(isArabic ? 'خطأ' : 'Error',
            isArabic ? 'البريد الالكتروني خطأ' : 'invalid email');
        break;
      case 'wrong-password':
        CommonMethods().showMessage(isArabic ? 'خطأ' : 'Error',
            isArabic ? 'كلمة المرور خطأ' : 'Wrong Password');
        break;
      case 'weak-password':
        CommonMethods().showMessage(isArabic ? 'خطأ' : 'Error',
            isArabic ? 'كلمة المرور ضعيفة' : 'Weak Password');
        break;
    }
  }
}
