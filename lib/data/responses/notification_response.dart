class NotificationResponse {
  bool status;
  List<NotificationModel> notifications;

  NotificationResponse({this.status, this.notifications});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      notifications = new List<NotificationModel>();
      json['data'].forEach((v) {
        notifications.add(new NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.notifications != null) {
      data['data'] = this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationModel {
  int id;
  String title;
  String body;
  String read;
  String type;
  int typeId;
  int userId;
  String image;
  int unixTime;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.read,
    this.type,
    this.typeId,
    this.userId,
    this.image,
    this.unixTime,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    read = json['read'];
    type = json['type'];
    image = json['image'];
    typeId = json['type_id'];
    userId = json['user_id'];
    unixTime = json['unixTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['read'] = this.read;
    data['type'] = this.type;
    data['image'] = this.image;
    data['type_id'] = this.typeId;
    data['user_id'] = this.userId;
    data['unixTime'] = this.unixTime;
    return data;
  }
}
