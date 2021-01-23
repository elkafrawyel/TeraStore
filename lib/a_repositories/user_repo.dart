import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/a_storage/network/user/user_service.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/data/requests/change_password_request.dart';
import 'package:tera/data/requests/edit_profile_request.dart';
import 'package:tera/data/requests/firebase_token_request.dart';
import 'package:tera/data/requests/login_request.dart';
import 'package:tera/data/requests/register_request.dart';
import 'package:tera/data/requests/social_request.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/user_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';
import 'package:tera/screens/auth/login_screen.dart';
import 'package:tera/screens/auth/verify_phone_screen.dart';
import 'package:tera/screens/home_screen/home_screen.dart';

class UserRepo {
  Future<void> register(RegisterRequest registerRequest) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);
    NetworkMethods().handleResponse(
        call: service.register(registerRequest),
        whenSuccess: (response) {
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
            CommonMethods().showSnackBar(
              userResponse.message,
            );
          } else {
            if (userResponse.message.isNotEmpty) {
              CommonMethods().showSnackBar(
                userResponse.message,
                iconData: Icons.error,
              );
            } else {
              VErrors errors = userResponse.vErrors;
              errors.printErrors();
            }
          }
        });
  }

  login(LoginRequest loginRequest) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    NetworkMethods().handleResponse(
      call: service.login(loginRequest),
      whenSuccess: (response) {
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
          CommonMethods().showSnackBar(
            userResponse.message,
          );
        } else {
          if (userResponse.message.isNotEmpty) {
            CommonMethods()
                .showSnackBar(userResponse.message, iconData: Icons.error);
          } else {
            VErrors errors = userResponse.vErrors;
            errors.printErrors();
          }
        }
      },
    );
  }

  Future<void> socialSignUp(SocialRequest socialRequest) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    NetworkMethods().handleResponse(
        call: service.socialSignUp(socialRequest),
        whenSuccess: (response) async {
          UserResponse userResponse = UserResponse.fromJson(response.body);
          if (userResponse.status && userResponse.data.apiToken != null) {
            UserModel userModel = userResponse.data;
            saveUser(userModel);
            // if (userModel.phone == null) {
            //   String phone = await _showGetPhoneDialog();
            //   if (phone == null) {
            //     CommonMethods().showMessage('message'.tr, 'enterPhone'.tr);
            //   } else {
            //     userModel.phone = phone;
            //     await editProfile(
            //       EditProfileRequest(
            //           name: userModel.name,
            //           email: userModel.email,
            //           phone: userModel.phone),
            //     );
            //     if (userModel.approved == 'yes') {
            //       Get.offAll(HomeScreen());
            //     } else {
            //       Get.offAll(VerifyPhoneScreen());
            //     }
            //   }
            // } else {
            //   if (userModel.approved == 'yes') {
            Get.offAll(HomeScreen());
            // } else {
            //   Get.offAll(VerifyPhoneScreen());
            // }
            // }

            CommonMethods().showSnackBar(userResponse.message);
          } else {
            if (userResponse.message != null &&
                userResponse.message != "" &&
                userResponse.message.isNotEmpty) {
              CommonMethods()
                  .showSnackBar(userResponse.message, iconData: Icons.error);
            } else {
              VErrors errors = userResponse.vErrors;
              errors.printErrors();
            }
          }
        });
  }

  Future<void> editProfile(
    EditProfileRequest editProfileRequest, {
    String imagePath,
  }) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    if (imagePath != null) {
      NetworkMethods().handleResponse(
          call: service.editProfileWithImage(editProfileRequest.name,
              editProfileRequest.email, editProfileRequest.phone, imagePath),
          whenSuccess: (response) {
            UserResponse userResponse = UserResponse.fromJson(response.body);
            if (userResponse.status && userResponse.data.apiToken != null) {
              UserModel userModel = userResponse.data;
              //save user id and update login state
              saveUser(userModel);
            } else {
              if (userResponse.message.isNotEmpty) {
                CommonMethods().showSnackBar(userResponse.message);
              } else {
                VErrors errors = userResponse.vErrors;
                errors.printErrors();
              }
            }
          });
    } else {
      NetworkMethods().handleResponse(
          call: service.editProfile(editProfileRequest),
          whenSuccess: (response) {
            UserResponse userResponse = UserResponse.fromJson(response.body);
            if (userResponse.status && userResponse.data.apiToken != null) {
              UserModel userModel = userResponse.data;
              //save user id and update login state
              saveUser(userModel);
            } else {
              if (userResponse.message.isNotEmpty) {
                CommonMethods().showSnackBar(userResponse.message);
              } else {
                VErrors errors = userResponse.vErrors;
                errors.printErrors();
              }
            }
          });
    }
  }

  profile() async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    NetworkMethods().handleResponse(
        call: service.profile(),
        whenSuccess: (response) {
          UserResponse userResponse = UserResponse.fromJson(response.body);
          if (userResponse.status && userResponse.data.apiToken != null) {
            UserModel userModel = userResponse.data;
            saveUser(userModel);
          } else {
            if (userResponse.message.isNotEmpty) {
              CommonMethods().showSnackBar(
                userResponse.message,
              );
            } else {
              VErrors errors = userResponse.vErrors;
              errors.printErrors();
            }
          }
        });
  }

  sendFireBaseToken(String fireBaseToken) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    NetworkMethods().handleResponse(
        call: service.createFireBaseToken(
          FirebaseTokenRequest(
            firebaseToken: fireBaseToken,
          ),
        ),
        whenSuccess: (response) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            print('Firebase token updated');
          }
        });
  }

  saveUser(UserModel userModel) {
    LocalStorage().setBool(LocalStorage.loginKey, true);
    LocalStorage().setString(LocalStorage.token, userModel.apiToken);
    LocalStorage().setString(LocalStorage.userId, userModel.id.toString());
    Get.find<MainController>().user = userModel;
    print('User Saved ==> ${userModel.apiToken}');
  }

  logOut() async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    NetworkMethods().handleResponse(
        call: service.logOut(),
        whenSuccess: (response) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            localLogOut();
            CommonMethods().showSnackBar(
              infoResponse.message,
            );
          } else {
            CommonMethods().showSnackBar(
              infoResponse.message,
              iconData: Icons.error,
            );
          }
        });
  }

  changePassword(ChangePasswordRequest changePasswordRequest,
      {Function(DataResource callState) state}) async {
    UserService service = UserService.create(NetworkBaseUrlType.MainUrl);

    NetworkMethods().handleResponse(
        call: service.changePassword(changePasswordRequest),
        whenSuccess: (response) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            CommonMethods().showSnackBar(
              infoResponse.message,
            );
            state(Success());
          } else {
            CommonMethods().showSnackBar(
              infoResponse.message,
              iconData: Icons.error,
            );
            state(Failure());
          }
        });
  }

  localLogOut() {
    LocalStorage().clear();
    Get.find<CartController>().cart?.cartItems?.clear();
    Get.find<MainController>().user = null;
    Get.offAll(LoginScreen());
  }

// Future<String> _showGetPhoneDialog() async {
//   TextEditingController controller = TextEditingController();
//   String phone;
//   await showDialog<String>(
//     barrierDismissible: true,
//     context: Get.context,
//     builder: (context) {
//       return AlertDialog(
//         title: CustomText(
//           text: 'enterPhone'.tr,
//         ),
//         contentPadding: const EdgeInsets.all(16.0),
//         content: Row(
//           children: <Widget>[
//             Expanded(
//               child: new TextField(
//                 controller: controller,
//                 keyboardType: TextInputType.phone,
//                 autofocus: true,
//                 decoration: new InputDecoration(
//                     hintText: 'phone'.tr, suffixText: '+2'),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           FlatButton(
//               child: Text('ok'.tr),
//               onPressed: () {
//                 if (controller.text.isNotEmpty) {
//                   if (GetUtils.isPhoneNumber(controller.text)) {
//                     phone = controller.text;
//                     Navigator.pop(context);
//                   } else {
//                     CommonMethods()
//                         .showMessage('message'.tr, 'enterValidPhone'.tr);
//                   }
//                 } else {
//                   CommonMethods()
//                       .showMessage('message'.tr, 'Enter your phone number');
//                 }
//               }),
//         ],
//       );
//     },
//   );
//   return phone;
// }
}
