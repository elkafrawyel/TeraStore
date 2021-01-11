class ImageModel {
  String url;

  ImageModel(this.url);

  ImageModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    url = map['url'];
  }

  toJson() {
    return {
      'url': url,
    };
  }
}
