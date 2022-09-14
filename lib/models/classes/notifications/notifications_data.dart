import 'package:go_on_get_it/models/classes/notifications/notifications_list_data.dart';

class Notifications {
  bool? error;
  String? message;
  NotificationsData? data;

  Notifications({this.error, this.message, this.data});

  Notifications.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new NotificationsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


class NotificationsData {
  int? count;
  List<NotificationDataRows>? rows;

  NotificationsData({this.count, this.rows});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <NotificationDataRows>[];
      json['rows'].forEach((v) {
        rows!.add(new NotificationDataRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}