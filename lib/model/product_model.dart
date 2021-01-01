class ProductModel {
  String id, name, description, image, userId, subCategoryId, timeStamp;
  int discountPrice, price;

  bool isNew = false;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.userId,
      this.subCategoryId,
      this.discountPrice,
      this.price,
      this.timeStamp});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    id = map['id'];
    image = map['image'];
    subCategoryId = map['subCategoryId'];
    timeStamp = map['timeStamp'];
    price = map['price'];
    discountPrice = map['discountPrice'];
    name = map['name'];
    description = map['description'];
    timeStamp = map['timeStamp'];
  }

  toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'subCategoryId': subCategoryId,
      'description': description,
      'discountPrice': discountPrice,
      'price': price,
      'image': image,
      'timeStamp': timeStamp,
    };
  }

  @override
  String toString() {
    return 'id : $id - name : $name - image : $image ';
  }
}
