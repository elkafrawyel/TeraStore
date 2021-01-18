import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/user_model.dart';

class ProductDetailsResponse {
  bool status;
  SingleItem singleItem;
  List<ProductModel> similarItems;

  ProductDetailsResponse({this.status, this.singleItem, this.similarItems});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    singleItem = SingleItem.fromJson(json['singleItem']);
    similarItems = List<ProductModel>();
    json['similarItems'].forEach((v) {
      similarItems.add(ProductModel.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.singleItem != null) {
      data['singleItem'] = this.singleItem.toJson();
    }
    if (this.similarItems != null) {
      data['similarItems'] = this.similarItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleItem {
  int id;
  String itemName;
  String itemDescribe;
  String itemImage;
  String itemPrice;
  int itemPriceAfterDis;
  String itemCount;
  int subCatId;
  int userId;
  String viewInBanner;
  String withProp;
  String discountType;
  int discountValue;
  bool isFav;
  bool inCart;
  UserModel user;
  List<ItemProperity> properities;
  List<SingleItemImage> images;

  SingleItem(
      {this.id,
      this.itemName,
      this.itemDescribe,
      this.itemImage,
      this.itemPrice,
      this.itemPriceAfterDis,
      this.itemCount,
      this.subCatId,
      this.userId,
      this.withProp,
      this.discountType,
      this.discountValue,
      this.isFav,
      this.inCart,
      this.user,
      this.properities,
      this.images});

  SingleItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    itemDescribe = json['itemDescribe'];
    itemImage = json['itemImage'];
    itemPrice = json['itemPrice'];
    itemPriceAfterDis = json['itemPriceAfterDis'];
    itemCount = json['itemCount'];
    subCatId = json['sub_cat_id'];
    userId = json['user_id'];
    viewInBanner = json['viewInBanner'];
    withProp = json['withProp'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    isFav = json['isFav'];
    inCart = json['inCart'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['item_properities'] != null) {
      properities = new List<ItemProperity>();
      json['item_properities'].forEach((v) {
        properities.add(ItemProperity.fromJson(v));
      });
    }
    if (json['other_item_images'] != null) {
      images = new List<SingleItemImage>();
      json['other_item_images'].forEach((v) {
        images.add(new SingleItemImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['itemDescribe'] = this.itemDescribe;
    data['itemImage'] = this.itemImage;
    data['itemPrice'] = this.itemPrice;
    data['itemPriceAfterDis'] = this.itemPriceAfterDis;
    data['itemCount'] = this.itemCount;
    data['sub_cat_id'] = this.subCatId;
    data['user_id'] = this.userId;
    data['viewInBanner'] = this.viewInBanner;
    data['withProp'] = this.withProp;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['isFav'] = this.isFav;
    data['inCart'] = this.inCart;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.properities != null) {
      data['item_properities'] =
          this.properities.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['other_item_images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemProperity {
  int id;
  String itemPropertyName;
  int itemId;
  List<ItemPropPlus> itemPropPlus;

  ItemProperity(
      {this.id, this.itemPropertyName, this.itemId, this.itemPropPlus});

  ItemProperity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemPropertyName = json['itemProperityName'];
    itemId = json['item_id'];
    if (json['item_prop_plus'] != null) {
      itemPropPlus = new List<ItemPropPlus>();
      json['item_prop_plus'].forEach((v) {
        itemPropPlus.add(new ItemPropPlus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemProperityName'] = this.itemPropertyName;
    data['item_id'] = this.itemId;
    if (this.itemPropPlus != null) {
      data['item_prop_plus'] =
          this.itemPropPlus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemPropPlus {
  int id;
  String propertyValue;
  String propertyDetails;
  String propertyPrice;
  int properityId;
  bool isSelected = false;

  ItemPropPlus(
      {this.id,
      this.propertyValue,
      this.propertyDetails,
      this.propertyPrice,
      this.properityId});

  ItemPropPlus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyValue = json['propertyValue'];
    propertyDetails = json['propertyDetails'];
    propertyPrice = json['propertyPrice'];
    properityId = json['properity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['propertyValue'] = this.propertyValue;
    data['propertyDetails'] = this.propertyDetails;
    data['propertyPrice'] = this.propertyPrice;
    data['properity_id'] = this.properityId;
    return data;
  }
}

class SingleItemImage {
  int id;
  String itemImageName;
  int itemId;

  SingleItemImage({this.id, this.itemImageName, this.itemId});

  SingleItemImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemImageName = json['itemImageName'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemImageName'] = this.itemImageName;
    data['item_id'] = this.itemId;
    return data;
  }
}
