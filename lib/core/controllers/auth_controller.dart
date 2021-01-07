import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends MainController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();

  signInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(googleAuthCredential);

      saveUser(UserModel(
          id: userCredential.user.uid,
          email: userCredential.user.email,
          name: userCredential.user.displayName,
          photo: userCredential.user.photoURL));
    } on FirebaseAuthException catch (e) {
      handleError(e);
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  signInFacebook() async {
    UserCredential userCredential;
    try {
      FacebookLoginResult result = await _facebookLogin.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.error:
          print("Error");
          CommonMethods().showMessage('Error', result.errorMessage);
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("CancelledByUser");
          CommonMethods().showMessage('Error', result.errorMessage);
          break;
        case FacebookLoginStatus.loggedIn:
          print("LoggedIn");
          final accessToken = result.accessToken.token;
          final facebookAuthCredential =
              FacebookAuthProvider.credential(accessToken);
          userCredential =
              await _auth.signInWithCredential(facebookAuthCredential);
          saveUser(UserModel(
              id: userCredential.user.uid,
              email: userCredential.user.email,
              name: userCredential.user.displayName,
              photo: userCredential.user.photoURL));
          break;
      }
    } on FirebaseAuthException catch (e) {
      handleError(e);
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  signInEmail(String email, String password) async {
    loading.value = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(HomeScreen());
    } on FirebaseAuthException catch (e) {
      handleError(e);
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    loading.value = false;
    update();
  }

  createAccount(String name, String email, String password) async {
    loading.value = true;
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      saveUser(UserModel(
          id: credential.user.uid,
          email: email,
          name: name,
          photo: defaultImageUrl));
    } on FirebaseAuthException catch (e) {
      handleError(e);
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    loading.value = false;
    update();
  }

  void saveUser(UserModel user) async {
    await UserService().addUserToFireStore(user);
    Get.offAll(HomeScreen());
  }

  handleError(error) {
    bool isArabic = LocalStorage().isArabicLanguage();
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
