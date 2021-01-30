import 'package:tera/a_storage/local_storage.dart';

class PrivacyPoliciesResponse {
  bool status;
  List<PrivacyPolicyModel> data;

  PrivacyPoliciesResponse({this.status, this.data});

  PrivacyPoliciesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<PrivacyPolicyModel>();
      json['data'].forEach((v) {
        data.add(new PrivacyPolicyModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrivacyPolicyModel {
  int id;
  String privacyTitle;
  String privacyTitleAr;
  String privacy;
  String privacyAr;
  String type;

  PrivacyPolicyModel(
      {this.id,
      this.privacyTitle,
      this.privacyTitleAr,
      this.privacy,
      this.privacyAr,
      this.type});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    privacyTitle = json['privacyTitle'];
    privacyTitleAr = json['privacyTitleAr'];
    privacy = json['privacy'];
    privacyAr = json['privacyAr'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['privacyTitle'] = this.privacyTitle;
    data['privacyTitleAr'] = this.privacyTitleAr;
    data['privacy'] = this.privacy;
    data['privacyAr'] = this.privacyAr;
    data['type'] = this.type;
    return data;
  }

  String title() {
    return LocalStorage().isArabicLanguage() ? privacyTitleAr : privacyTitle;
  }

  String body() {
    return LocalStorage().isArabicLanguage() ? privacyAr : privacy;
  }
}
