import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:pin_entry_field/pin_entry_field.dart';
import 'package:pin_entry_field/pin_entry_style.dart';
import 'package:pin_entry_field/pin_input_type.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final UserModel userModel;

  const VerifyPhoneScreen({Key key, this.userModel}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String verificationId;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    phoneController.text =
        widget.userModel.phone == null ? '' : widget.userModel.phone;
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Verification Phone',
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlinedTextFormField(
                text: 'phone'.tr,
                hintText: 'phoneHint'.tr,
                controller: phoneController,
                validateEmptyText: 'Phone Empty',
                keyboardType: TextInputType.phone,
                labelText: 'Phone',
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  text: 'Send Code',
                  colorBackground: LocalStorage().primaryColor(),
                  colorText: Colors.white,
                  fontSize: 18,
                  onPressed: () {
                    if (widget.userModel.phone == null &&
                        phoneController.text.isEmpty) {
                      CommonMethods()
                          .showMessage('message'.tr, 'Enter your phone number');
                    } else {
                      verifyPhone(phoneController.text);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: codeSent,
                child: CustomText(
                  text:
                      'A message with a verification code will arrive to your phone now.',
                  fontSize: 16,
                  alignment: AlignmentDirectional.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: codeSent,
                child: PinEntryField(
                  inputType: PinInputType.none,
                  // pinInputCustom: "-",
                  onSubmit: (text) {
                    codeController.text = text;
                  },
                  fieldCount: 6,
                  fieldWidth: 40,
                  height: 50,
                  fieldStyle: PinEntryStyle(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      fieldBackgroundColor: LocalStorage().primaryColor(),
                      fieldBorderRadius: BorderRadius.circular(10),
                      fieldPadding: 10),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: codeSent,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: CustomButton(
                    text: 'Verify',
                    colorBackground: LocalStorage().primaryColor(),
                    colorText: Colors.white,
                    fontSize: 18,
                    onPressed: () {
                      loginWithPhone();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  verifyPhone(String phone) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    // _auth.setLanguageCode("ar");
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        codeAutoRetrievalTimeout: (verificationId) {},
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            this.verificationId = verificationId;
            this.codeSent = true;
          });
          // CommonMethods().showMessage('message'.tr, 'codeSent'.tr);
        },
        timeout: Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) {
          print('verificationCompleted');
          Get.back();
          LocalStorage().setBool(LocalStorage.phoneVerified, true);
        },
        verificationFailed: (AuthException authException) {
          CommonMethods().showMessage('errorTitle'.tr, authException.message);
        },
        forceResendingToken: 3);
  }

  void loginWithPhone() {
    FirebaseAuth auth = FirebaseAuth.instance;

    String smsCode = codeController.text.trim();

    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    auth.signInWithCredential(credential).then((AuthResult result) {
      CommonMethods().showMessage('message'.tr, 'Phone Number verified.');

      widget.userModel.phoneVerified = true;
      Get.find<MainController>().user = widget.userModel;
      UserService().addUserToFireStore(widget.userModel);
      LocalStorage().setBool(LocalStorage.phoneVerified, true);
      Get.offAll(
        HomeScreen(),
      );
    }).catchError((e) {
      print(e);
    });
  }
}
