import 'package:tera/data/models/user_model.dart';

class ReviewsResponse {
  List<ReviewModel> usersItemComment;
  int productRate;
  bool status;

  ReviewsResponse({this.usersItemComment, this.productRate, this.status});

  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    if (json['users_item_comment'] != null) {
      usersItemComment = new List<ReviewModel>();
      json['users_item_comment'].forEach((v) {
        usersItemComment.add(new ReviewModel.fromJson(v));
      });
    }
    productRate = json['rate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.usersItemComment != null) {
      data['users_item_comment'] =
          this.usersItemComment.map((v) => v.toJson()).toList();
    }
    data['rate'] = this.productRate;
    data['status'] = this.status;
    return data;
  }
}

class ReviewModel {
  String comment;
  int userId;
  int rate;
  String createdAt;
  bool isCommented;
  int unixTime;
  UserModel user;

  ReviewModel(
      {this.comment,
      this.userId,
      this.rate,
      this.createdAt,
      this.isCommented,
      this.unixTime,
      this.user});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    userId = json['user_id'];
    rate = json['rate'];
    createdAt = json['created_at'];
    isCommented = json['is_commented'];
    unixTime = json['unixTime'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['is_commented'] = this.isCommented;
    data['unixTime'] = this.unixTime;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
