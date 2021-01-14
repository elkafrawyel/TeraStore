import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tera/a_repositories/user_repo.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/a_storage/network/user/user_service.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/graph_model.dart';
import 'package:tera/data/requests/login_request.dart';
import 'package:tera/data/requests/register_request.dart';
import 'package:tera/data/requests/social_request.dart';
import 'package:tera/helper/CommonMethods.dart';

import 'main_controller.dart';

class AuthController extends MainController {
  bool isArabic = LocalStorage().isArabicLanguage();

  void login(String email, String password) async {
    loading.value = true;
    update();

    await UserRepo().login(LoginRequest(
      email: email,
      password: password,
    ));

    loading.value = false;
    update();
  }

  void register(
      String name, String email, String phone, String password) async {
    loading.value = true;
    update();
    await UserRepo().register(RegisterRequest(
      name: name,
      email: email,
      phone: phone,
      password: password,
    ));
    loading.value = false;
    update();
  }

  void signInGoogle() async {
    final GoogleSignInAccount googleUser =
        await GoogleSignIn(scopes: ['profile']).signIn();

    SocialRequest socialRequest = SocialRequest(
        name: googleUser.displayName,
        email: googleUser.email,
        image: googleUser.photoUrl,
        socialType: 'google',
        uid: googleUser.id);

    await UserRepo().socialSignUp(socialRequest);
  }

  void signInFacebook() async {
    FacebookLoginResult result = await FacebookLogin().logIn(['email']);
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
        final fields = 'name,first_name,last_name,email,picture.height(800)';

        var myService = UserService.create(NetworkBaseUrlType.GraphUrl);
        var response = await myService.getFacebookGraph(accessToken, fields);
        GraphModel graphModel = GraphModel.fromJson(response.body);

        String photoUrl = graphModel.picture.data.url;

        SocialRequest socialRequest = SocialRequest(
            name: graphModel.name,
            email: graphModel.email,
            image: photoUrl,
            socialType: 'face',
            uid: graphModel.id);

        await UserRepo().socialSignUp(socialRequest);
    }
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
