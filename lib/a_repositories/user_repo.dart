import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/a_storage/network/user/user_service.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/data/requests/edit_profile_request.dart';
import 'package:tera/data/requests/firebase_token_request.dart';
import 'package:tera/data/requests/login_request.dart';
import 'package:tera/data/requests/register_request.dart';
import 'package:tera/data/requests/social_request.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/user_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/network_methods.dart';
import 'package:tera/screens/auth/login_screen.dart';
import 'package:tera/screens/auth/verify_phone_screen.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/home_screen/home_screen.dart';

class UserRepo {
  //login , register, edit, verify, logOut,

  Future<void> register(RegisterRequest registerRequest) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    chopper.Response response = await service.register(registerRequest);
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        UserResponse userResponse = UserResponse.fromJson(response.body);
        if (userResponse.status && userResponse.data.apiToken != null) {
          UserModel userModel = userResponse.data;
          //save user id and update login state
          saveUser(userModel);
          if (userModel.approved == 'yes') {
            Get.offAll(HomeScreen());
          } else {
            Get.offAll(VerifyPhoneScreen());
          }
          CommonMethods().showMessage('message'.tr, userResponse.message);
        } else {
          if (userResponse.message.isNotEmpty) {
            CommonMethods().showMessage('errorTitle'.tr, userResponse.message);
          } else {
            VErrors errors = userResponse.vErrors;
            errors.printErrors();
          }
        }
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');

        break;
    }
  }

  login(LoginRequest loginRequest) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    chopper.Response response = await service.login(loginRequest);
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        UserResponse userResponse = UserResponse.fromJson(response.body);
        if (userResponse.status && userResponse.data.apiToken != null) {
          UserModel userModel = userResponse.data;
          //save user id and update login state
          saveUser(userModel);
          if (userModel.approved == 'yes') {
            Get.offAll(HomeScreen());
          } else {
            Get.offAll(VerifyPhoneScreen());
          }
          CommonMethods().showMessage('message'.tr, userResponse.message);
        } else {
          if (userResponse.message.isNotEmpty) {
            CommonMethods().showMessage('errorTitle'.tr, userResponse.message);
          } else {
            VErrors errors = userResponse.vErrors;
            errors.printErrors();
          }
        }
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');

        break;
    }
  }

  Future<void> socialSignUp(SocialRequest socialRequest) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    chopper.Response response = await service.socialSignUp(socialRequest);
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        UserResponse userResponse = UserResponse.fromJson(response.body);
        if (userResponse.status && userResponse.data.apiToken != null) {
          UserModel userModel = userResponse.data;
          saveUser(userModel);
          if (userModel.phone == null) {
            String phone = await _showGetPhoneDialog();
            if (phone == null) {
              CommonMethods().showMessage('message'.tr, 'enterPhone'.tr);
            } else {
              userModel.phone = phone;
              await editProfile(
                EditProfileRequest(
                    name: userModel.name,
                    email: userModel.email,
                    phone: userModel.phone),
              );
              if (userModel.approved == 'yes') {
                Get.offAll(HomeScreen());
              } else {
                Get.offAll(VerifyPhoneScreen());
              }
            }
          } else {
            if (userModel.approved == 'yes') {
              Get.offAll(HomeScreen());
            } else {
              Get.offAll(VerifyPhoneScreen());
            }
          }

          CommonMethods().showMessage('message'.tr, userResponse.message);
        } else {
          if (userResponse.message.isNotEmpty) {
            CommonMethods().showMessage('errorTitle'.tr, userResponse.message);
          } else {
            VErrors errors = userResponse.vErrors;
            errors.printErrors();
          }
        }
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
        break;
    }
  }

  Future<void> editProfile(EditProfileRequest editProfileRequest,
      {String imagePath}) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    if (imagePath != null) {
      chopper.Response response = await service.editProfileWithImage(
          editProfileRequest.name,
          editProfileRequest.email,
          editProfileRequest.phone,
          imagePath);
      switch (NetworkMethods().handleResponse(response)) {
        case ApiState.success:
          UserResponse userResponse = UserResponse.fromJson(response.body);
          if (userResponse.status && userResponse.data.apiToken != null) {
            UserModel userModel = userResponse.data;
            //save user id and update login state
            saveUser(userModel);
          } else {
            if (userResponse.message.isNotEmpty) {
              CommonMethods()
                  .showMessage('errorTitle'.tr, userResponse.message);
            } else {
              VErrors errors = userResponse.vErrors;
              errors.printErrors();
            }
          }
          break;
        case ApiState.error:
          CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
          break;
        case ApiState.unauthorized:
          UserRepo().localLogOut();
          CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
          break;
      }
    } else {
      chopper.Response response = await service.editProfile(editProfileRequest);
      switch (NetworkMethods().handleResponse(response)) {
        case ApiState.success:
          UserResponse userResponse = UserResponse.fromJson(response.body);
          if (userResponse.status && userResponse.data.apiToken != null) {
            UserModel userModel = userResponse.data;
            //save user id and update login state
            saveUser(userModel);
          } else {
            if (userResponse.message.isNotEmpty) {
              CommonMethods()
                  .showMessage('errorTitle'.tr, userResponse.message);
            } else {
              VErrors errors = userResponse.vErrors;
              errors.printErrors();
            }
          }
          break;
        case ApiState.error:
          CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
          break;
        case ApiState.unauthorized:
          UserRepo().localLogOut();
          CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
          break;
      }
    }
  }

  profile() async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    chopper.Response response = await service.profile();
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        UserResponse userResponse = UserResponse.fromJson(response.body);
        if (userResponse.status && userResponse.data.apiToken != null) {
          UserModel userModel = userResponse.data;
          saveUser(userModel);
        } else {
          if (userResponse.message.isNotEmpty) {
            CommonMethods().showMessage('errorTitle'.tr, userResponse.message);
          } else {
            VErrors errors = userResponse.vErrors;
            errors.printErrors();
          }
        }
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
        break;
    }
  }

  sendFireBaseToken(String fireBaseToken) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    chopper.Response response = await service.createFireBaseToken(
        FirebaseTokenRequest(firebaseToken: fireBaseToken));
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        InfoResponse infoResponse = InfoResponse.fromJson(response.body);
        if (infoResponse.status) {
          print('Firebase token updated');
        }
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
        break;
    }
  }

  saveUser(UserModel userModel) {
    LocalStorage().setBool(LocalStorage.loginKey, true);
    LocalStorage().setString(LocalStorage.token, userModel.apiToken);
    LocalStorage().setString(LocalStorage.userId, userModel.id.toString());
    Get.find<MainController>().user = userModel;
    print('User Saved ==================> ${userModel.apiToken}');
  }

  logOut() async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);
    chopper.Response response = await service.logOut();
    switch (NetworkMethods().handleResponse(response)) {
      case ApiState.success:
        InfoResponse infoResponse = InfoResponse.fromJson(response.body);
        if (infoResponse.status) {
          localLogOut();
          CommonMethods().showMessage('message'.tr, infoResponse.message);
        } else {
          CommonMethods().showMessage('errorTitle'.tr, infoResponse.message);
        }
        break;
      case ApiState.error:
        CommonMethods().showMessage('errorTitle'.tr, 'error'.tr);
        break;
      case ApiState.unauthorized:
        UserRepo().localLogOut();
        CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
        break;
    }
  }

  localLogOut() {
    LocalStorage().clear();
    Get.find<CartController>().products.clear();
    Get.find<MainController>().user = null;
    Get.offAll(LoginScreen());
  }

  Future<String> _showGetPhoneDialog() async {
    TextEditingController controller = TextEditingController();
    String phone;
    await showDialog<String>(
      barrierDismissible: true,
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
                  decoration: new InputDecoration(
                      hintText: 'phone'.tr, suffixText: '+2'),
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
                      phone = controller.text;
                      Navigator.pop(context);
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
    return phone;
  }
}
