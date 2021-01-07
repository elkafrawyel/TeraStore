class ReviewModel {
  List<Review> reviews;

  ReviewModel({this.reviews});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      reviews = List<Review>.empty(growable: true);
      json['cart'].forEach((v) {
        reviews.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['cart'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  String id;
  String message;
  double rate;
  int time;
  String userName;
  String userImage;

  Review({this.id, this.message, this.rate,this.time,this.userName,this.userImage});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    rate = json['rate'];
    time = json['time'];
    userName = json['userName'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['rate'] = this.rate;
    data['time'] = this.time;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    return data;
  }
}
