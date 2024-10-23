import 'dart:convert';

import 'package:gym_mate_admin/services/get_services.dart';
import 'package:http/http.dart' as http;

class SendNotificationService {
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic> data,
  }) async {
    String serverKey = await GetServerKey().getServerKeyToken();
    print("Notifiction server key => ${serverKey}");
    String url =
        "https://fcm.googleapis.com/v1/projects/gym-mate-86c8a/messages:send";
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": title},
        "data": data,
      }
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print("Notification Send Successfully!");
    } else {
      print("Notifiction not send!");
    }
  }
}
