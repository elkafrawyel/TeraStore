class CartItem {
  int id;
  String cartItemPrice;
  String cartItemCount;
  int cartItemTotalPrice;
  int itemId;
  String itemImage;
  String itemName;
  String itemPrice;
  int itemPriceAfterDis;
  String itemCount;
  String withProp;
  String properitiesDescription;

  CartItem(
      {this.id,
      this.cartItemPrice,
      this.cartItemCount,
      this.cartItemTotalPrice,
      this.itemId,
      this.itemImage,
      this.itemName,
      this.itemPrice,
      this.itemPriceAfterDis,
      this.itemCount,
      this.withProp,
      this.properitiesDescription});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartItemPrice = json['cartItemPrice'];
    cartItemCount = json['cartItemCount'];
    cartItemTotalPrice = json['cartItemTotalPrice'];
    itemId = json['item_id'];
    itemImage = json['itemImage'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemPriceAfterDis = json['itemPriceAfterDis'];
    itemCount = json['itemCount'];
    withProp = json['withProp'];
    properitiesDescription = json['obj_prop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartItemPrice'] = this.cartItemPrice;
    data['cartItemCount'] = this.cartItemCount;
    data['cartItemTotalPrice'] = this.cartItemTotalPrice;
    data['item_id'] = this.itemId;
    data['itemImage'] = this.itemImage;
    data['itemName'] = this.itemName;
    data['itemPrice'] = this.itemPrice;
    data['itemPriceAfterDis'] = this.itemPriceAfterDis;
    data['itemCount'] = this.itemCount;
    data['withProp'] = this.withProp;
    data['obj_prop'] = this.properitiesDescription;
    return data;
  }
}
