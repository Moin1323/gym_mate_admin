import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_mate_admin/services/get_services.dart';
import 'package:gym_mate_admin/services/send_notification.dart';

import '../../../../res/colors/app_colors.dart';

class Notifications_view extends StatefulWidget {
  const Notifications_view({super.key});

  @override
  State<Notifications_view> createState() => _Notifications_viewState();
}

class _Notifications_viewState extends State<Notifications_view> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to get the current user's ID
  Future<String?> _getCurrentUserId() async {
    User? user = _auth.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    // Define dynamic title and body
    String notificationTitle = "Hello👋🏻";
    String notificationBody = "Please Submit your this month fee kindly⚠️";

    String notificationTitle1 = "Hello👋🏻";
    String notificationBody1 = "Here the new offer visit Gym 🎁!";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Row(
            children: [
              const SizedBox(width: 30),
              Text(
                'Notifications',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.notifications,
                color: AppColors.secondary,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () async {
                  GetServerKey getServerKey = GetServerKey();
                  String accessToken = await getServerKey.getServerKeyToken();
                  print(accessToken);
                },
                child: const Text(
                  'Gen Api Token',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () async {
                await _sendNotificationAndSave(
                    title: notificationTitle,
                    body: notificationBody,
                    token:
                        "c7tt7D-PRTOzinx-c7h3XW:APA91bFcOPYLVNsC1RGihnin8NEPp8pU_ms9smvqh8KVW57SxY-nH35bmALB4k58xf0Gw1XpYaI8hDrlgK1eDckxNuHXemnqGkKN9Z6DMxuO-LRHLeXGMeM");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Center(
                      child: Text(
                        "Notification sent successfully!",
                        style: TextStyle(color: AppColors.background),
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                'Send Fee Nf🔔',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () async {
                await _sendNotificationAndSave(
                    title: notificationTitle1,
                    body: notificationBody1,
                    token:
                        "c7tt7D-PRTOzinx-c7h3XW:APA91bFcOPYLVNsC1RGihnin8NEPp8pU_ms9smvqh8KVW57SxY-nH35bmALB4k58xf0Gw1XpYaI8hDrlgK1eDckxNuHXemnqGkKN9Z6DMxuO-LRHLeXGMeM");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Center(
                      child: Text(
                        "Notification sent successfully!",
                        style: TextStyle(color: AppColors.background),
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                'Send Offer Notification🔔',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Separate method to handle notification sending and saving
  Future<void> _sendNotificationAndSave(
      {required String title,
      required String body,
      required String token}) async {
    // Send the notification
    await SendNotificationService.sendNotificationUsingApi(
      token: token,
      title: title,
      body: body,
      data: {"screen": "cart"},
    );

    // Save notification in Firestore with user ID and timestamp
    String? userId = await _getCurrentUserId();
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(userId)
          .collection('user_notifications')
          .doc()
          .set({
        'title': title,
        'body': body,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
