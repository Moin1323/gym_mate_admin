import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/banner_widget.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/header_widget.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/tab_bar_view_widget.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/tab_bar_widget.dart';

import '../../../res/colors/app_colors.dart';
import '../../../services/notifications_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserController userController = Get.put(UserController());
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    userController.fetchUserData();
    userController.fetchAllUsers();
    userController.fetchAllExercises();
    notificationServices.requestNotificationPermission();
    notificationServices.initLocalNotifications(
        context, const RemoteMessage()); // Initialize local notifications
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value) {
      print('Device token: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.background,
    ));
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              HeaderWidget(userController: userController),
              const SizedBox(height: 10),
              const BannerWidget(),
              const SizedBox(height: 20),
              const TabBarWidget(),
              TabBarViewWidget(userController: userController),
            ],
          ),
        ),
      ),
    );
  }
}
