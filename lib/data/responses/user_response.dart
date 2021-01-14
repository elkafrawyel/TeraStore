import 'package:get/get.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/helper/CommonMethods.dart';

class UserResponse {
  bool status;
  String message;
  VErrors vErrors;
  UserModel data;

  UserResponse({this.status, this.message, this.vErrors, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vErrors = json['v_errors'] != null
        ? new VErrors.fromJson(json['v_errors'])
        : null;
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.vErrors != null) {
      data['v_errors'] = this.vErrors.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class VErrors {
  List<String> name;
  List<String> email;
  List<String> phone;
  List<String> password;
  List<String> socialType;

  VErrors({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.socialType,
  });

  VErrors.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) name = json['name'].cast<String>();
    if (json['email'] != null) email = json['email'].cast<String>();
    if (json['phone'] != null) phone = json['phone'].cast<String>();
    if (json['password'] != null) password = json['password'].cast<String>();
    if (json['socialType'] != null)
      socialType = json['socialType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['socialType'] = this.socialType;
    return data;
  }

  printErrors() {
    if (name != null) {
      CommonMethods().showMessage('errorTitle'.tr, name[0]);
      return;
    } else if (email != null) {
      CommonMethods().showMessage('errorTitle'.tr, email[0]);
      return;
    } else if (phone != null) {
      CommonMethods().showMessage('errorTitle'.tr, phone[0]);
      return;
    } else if (password != null) {
      CommonMethods().showMessage('errorTitle'.tr, password[0]);
      return;
    } else if (socialType != null) {
      CommonMethods().showMessage('errorTitle'.tr, socialType[0]);
      return;
    }
  }
}
