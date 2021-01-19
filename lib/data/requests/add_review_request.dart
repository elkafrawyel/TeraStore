class AddReviewRequest {
  String productId, comment, rate;

  AddReviewRequest({
    this.productId,
    this.comment,
    this.rate,
  });

  AddReviewRequest.fromJson(Map<String, dynamic> json) {
    productId = json['item_id'];
    comment = json['comment'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.productId;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    return data;
  }
}
