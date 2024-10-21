import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add FirebaseAuth to get user info
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

  // Function to get the current user's username or display name
  Future<String?> _getCurrentUserName() async {
    User? user = _auth.currentUser;
    return user
        ?.displayName; // Or use a specific field from your Firestore user document if available
  }

  @override
  Widget build(BuildContext context) {
    // Define dynamic title and body
    String notificationTitle = "Hello👋🏻";
    String notificationBody = "Please Submit your this month fee kindly!";

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          iconTheme: IconThemeData(
            color: Colors.white, // Set the leading arrow color to white
          ),
          title: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Notifications',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
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
                    backgroundColor:
                        AppColors.primary, // Background color of the button
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Adjust padding if needed
                  ),
                  onPressed: () async {
                    GetServerKey getServerkey = GetServerKey();
                    String acessToken = await getServerkey.getServerKeyToken();
                    print(acessToken);
                  },
                  child: Text(
                    'Gen Api Token',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16, // Text size
                      fontWeight: FontWeight.bold, // Text style (optional)
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primary, // Background color of the button
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Adjust padding if needed
                ),
                onPressed: () async {
                  // Send the notification
                  await SendNotificationService.sendNotificationUsingApi(
                    token:
                        "cF2tFbDPS3qYtmtv16sVb8:APA91bGB3I0XiaDoeGYpxZytpRpq4zNJ3lggX73M9q58iHCuVMzrbwlNO2YByIL-TuyrpTQb4OpP6JLDUGCsjrXz7lmF5PGGJnA-uGmsZWlYnTSPNNzAPaP8YIOh1YXVUcUy3ovJhBey",
                    title: notificationTitle, // Dynamic title
                    body: notificationBody, // Dynamic body
                    data: {
                      "screen": "cart",
                    },
                  );

                  // Save the notification in Firestore with user information and timestamp
                  String? userId = await _getCurrentUserId();
                  String? userName = await _getCurrentUserName();

                  if (userId != null) {
                    await FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(userId) // Store notifications by user ID
                        .collection('user_notifications')
                        .doc() // Auto-generated document ID for each notification
                        .set({
                      'title': notificationTitle, // Use dynamic title here
                      'body': notificationBody, // Use dynamic body here
                      'userId': userId,
                      'userName':
                          userName ?? 'Unknown', // Add username if available
                      'timestamp': FieldValue
                          .serverTimestamp(), // Save current server timestamp
                    });
                  }
                },
                child: Text(
                  'Send Fee Nf🔔',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Text style (optional)
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
