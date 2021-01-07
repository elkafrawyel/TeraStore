class FavouriteModel {
  List<FavouriteProduct> myProducts;

  FavouriteModel({this.myProducts});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    if (json['Products'] != null) {
      myProducts = List<FavouriteProduct>.empty(growable: true);
      json['Products'].forEach((v) {
        myProducts.add(FavouriteProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myProducts != null) {
      data['Products'] = this.myProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavouriteProduct {
  String id;

  FavouriteProduct({this.id});

  FavouriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
