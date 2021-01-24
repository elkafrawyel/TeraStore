class AddProductRequest {
  String subCategoryId,
      itemName,
      itemDescribe,
      itemPrice,
      discountValue,
      itemCount;

  AddProductRequest({
    this.subCategoryId,
    this.itemName,
    this.itemDescribe,
    this.itemPrice,
    this.discountValue,
    this.itemCount,
  });

  AddProductRequest.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_cat_id'];
    itemName = json['itemName'];
    itemDescribe = json['itemDescribe'];
    itemPrice = json['itemPrice'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_cat_id'] = this.subCategoryId;
    data['itemName'] = this.itemName;
    data['itemDescribe'] = this.itemDescribe;
    data['itemPrice'] = this.itemPrice;
    data['discountValue'] = this.discountValue;
    data['itemCount'] = this.itemCount;
    return data;
  }
}
