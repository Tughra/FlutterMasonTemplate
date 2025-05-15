import 'dart:convert';
import 'package:{{project_file_name}}/core/functions/random_generate_ids.dart';

//NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

//String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  final int? status;
  final List<NotificationDataModel>? data;
  final bool? pagination;

  NotificationListModel({
    this.status,
    this.data,
    this.pagination,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<NotificationDataModel>.from(json["data"]!.map((x) => NotificationDataModel.fromJson(x))),
    pagination: json["pagination"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination,
  };
}

class NotificationDataModel {
  final String? id;
  final String? cid;
  final String? title;
  final bool isRead;
  final String? body;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationDataModel({
    this.id,
    this.cid,
    this.title,
    this.isRead=false,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
    id: json["id"],
    cid: json["cid"],
    title: json["title"],
    body: json["body"],
    isRead: json["isRead"]??false,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cid": cid,
    "title": title,
    "body": body,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
  final regex = RegExp(r'''"([\"'])\s*((?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?:(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)(?:\.(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)*(?:\.(?:[a-zA-Z\u00a1-\uffff]{2,})))|localhost)(?::\d{2,5})?(?:\/(?:(?!\1|\s)[\S\s])*)?)\s*\1"''');

}



class CustomNotificationModel {
  CustomNotificationModel({
    required this.notificationID,
    this.title,
    this.body,
    this.channelId,
    this.messageType,
    this.image,
    this.payload,
    this.action1,
    this.action2,
    this.action3,
  });

  final int uniqueID = randomBetween(1, 99999);
  final int notificationID;
  final String? title;
  final String? body;
  final String? channelId;
  final String? messageType;
  final String? image;
  final String? payload;
  final String? action1;
  final String? action2;
  final String? action3;

  factory CustomNotificationModel.fromJson(Map<String, dynamic> json) => CustomNotificationModel(
        notificationID: json["uniqueID"] ?? randomBetween(1, 99999),
        title: json["title"],
        body: json["body"],
        channelId: json["channel-id"],
        messageType: json["message-type"],
        image: json["image"],
        payload: json["payload"],
        action1: json["action1"],
        action2: json["action2"],
        action3: json["action3"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueID": notificationID,
        "title": title,
        "body": body,
        "channel-id": channelId,
        "message-type": messageType,
        "payload": payload,
        "image": image,
        "action1": action1,
        "action2": action2,
        "action3": action3,
      };

  String encodeNotification() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> decodeNotification(String data) {
    return jsonDecode(data);
  }
}
