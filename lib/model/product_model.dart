import 'user_model.dart';

class ProductModel {
  String id,
      name,
      description,
      image,
      userId,
      categoryId,
      subCategoryId,
      timeStamp;
  int discountPrice, price;

  // add also category name, subCategory name,


  //run time attributes
  bool isNew = false;
  bool isFav = false;
  UserModel owner;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.discountPrice,
      this.price,
      this.timeStamp});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    id = map['id'];
    image = map['image'];
    categoryId = map['categoryId'];
    subCategoryId = map['subCategoryId'];
    timeStamp = map['timeStamp'];
    price = map['price'];
    userId = map['userId'];
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
      'categoryId': categoryId,
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
    return 'id : $id - name : $name';
  }
}
