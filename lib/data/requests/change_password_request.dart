class ChangePasswordRequest {
  String oldPassword, password, confirmPassword;

  ChangePasswordRequest(
      {this.oldPassword, this.password, this.confirmPassword});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldPassword;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }
}
