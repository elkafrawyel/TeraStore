class ProductModel {
  var id;
  var name;
  var description;
  var image;
  var price;
  var discountPrice;
  var userId;
  var discountType;
  var discountValue;
  var rate;
  bool isFav;
  bool inCart;
  int commentCount;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.discountPrice,
      this.userId,
      this.discountType,
      this.discountValue,
      this.isFav,
      this.rate,
      this.commentCount,
      this.inCart});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['itemName'];
    description = json['itemDescribe'];
    image = json['itemImage'];
    price = json['itemPrice'];
    discountPrice = json['itemPriceAfterDis'];
    userId = json['user_id'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    isFav = json['isFav'];
    inCart = json['inCart'];
    rate = json['rate'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.name;
    data['itemDescribe'] = this.description;
    data['itemImage'] = this.image;
    data['itemPrice'] = this.price;
    data['itemPriceAfterDis'] = this.discountPrice;
    data['user_id'] = this.userId;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['isFav'] = this.isFav;
    data['inCart'] = this.inCart;
    data['rate'] = this.rate;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
