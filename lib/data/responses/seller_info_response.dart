class SellerInfoResponse {
  bool status;
  SellerInformation information;

  SellerInfoResponse({this.status, this.information});

  SellerInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    information = json['data'] != null
        ? new SellerInformation.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.information != null) {
      data['data'] = this.information.toJson();
    }
    return data;
  }
}

class SellerInformation {
  int items;
  int purchase;
  int countSoldCartItems;

  SellerInformation({this.items, this.purchase, this.countSoldCartItems});

  SellerInformation.fromJson(Map<String, dynamic> json) {
    items = json['items'];
    purchase = json['purchase'];
    countSoldCartItems = json['countSoldCartItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] = this.items;
    data['purchase'] = this.purchase;
    data['countSoldCartItems'] = this.countSoldCartItems;
    return data;
  }
}
