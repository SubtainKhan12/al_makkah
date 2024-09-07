import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;


class PushNotificationServices {
  final FirebaseMessaging firebaseMessagingInstance =
      FirebaseMessaging.instance;

  Future sendNotification(String? deviceId, String title, String body) async {
    return await http.post(
        Uri(scheme: 'https', host: 'fcm.googleapis.com', path: 'fcm/send'),
        body: jsonEncode({
          "notification": {
            "title": title,
            "body": body,
            "android_channel_id": "iac"
          },
          "data": {
            "title": "title",
            "body": "body",
            'type': 'order',
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done"
          },
          "priority": "high",
          "to": deviceId ?? "/topics/iacadmin"
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          'AAAACU77tJ4:APA91bE4B5DCfwen7CLmktIhQTvNzZmcqoH0digDSqW6HVOtyWf5wGu2_2T9oDjW_BZM4XNsiyTPA4uv7SQ44UJu1k5Xz9jbROX31UBlmGYqtal2LNSD2PemVvMlXkC2zGwHlpEJkHlF',
        });
  }

  Future<String?> gettoken() async {
    return await firebaseMessagingInstance.getToken();
  }
}