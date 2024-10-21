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
  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white38,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Aligns the content to the start
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns the text to the start
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Gym_mate 💪',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 23),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'This is the test Notification ❤️‍🔥',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                  await SendNotificationService.sendNotificationUsingApi(
                    token:
                        "cF2tFbDPS3qYtmtv16sVb8:APA91bGB3I0XiaDoeGYpxZytpRpq4zNJ3lggX73M9q58iHCuVMzrbwlNO2YByIL-TuyrpTQb4OpP6JLDUGCsjrXz7lmF5PGGJnA-uGmsZWlYnTSPNNzAPaP8YIOh1YXVUcUy3ovJhBey",
                    title: "Notification Title",
                    body: "Notifiction Body",
                    data: {
                      "screen": "cart",
                    },
                  );
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
