class AddProductToCartRequest {
  String productId, productTotalPrice, productPropDescription;

  AddProductToCartRequest({
    this.productId,
    this.productTotalPrice,
    this.productPropDescription,
  });

  AddProductToCartRequest.fromJson(Map<String, dynamic> json) {
    productId = json['item_id'];
    productTotalPrice = json['itemPrice'];
    productPropDescription = json['itemPropPlus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.productId;
    data['itemPrice'] = this.productTotalPrice;
    data['itemPropPlus'] = this.productPropDescription;
    return data;
  }
}
