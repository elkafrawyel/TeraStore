class SocialRequest {
  String name, email, phone, socialType, uid, image;

  SocialRequest({
    this.name,
    this.email,
    this.socialType,
    this.phone,
    this.image,
    this.uid,
  });

  SocialRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    socialType = json['socialType'];
    uid = json['uid'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['socialType'] = this.socialType;
    data['uid'] = this.uid;
    return data;
  }
}
