import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/res/assets/image_assets.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/notifications_view.dart';
import 'package:gym_mate_admin/view_models/controller/login/login_view_model.dart';

import 'widgets/AccountTile.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final LoginViewModel loginVM = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Cover image section covering most of the screen height
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.primary,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 110.0, horizontal: 40),
                child: Image.asset(
                  alignment: Alignment.topCenter,
                  ImageAssets.logo,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
          // Draggable scrollable sheet containing user details and account tiles
          DraggableScrollableSheet(
            initialChildSize: 0.70,
            minChildSize: 0.70,
            maxChildSize: 0.80,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Settings heading
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text(
                        'Edit Settings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          // Account tiles section
                          const AccountTile(
                            accountName: 'Edit Profile',
                            leadingIcon: Icons.account_circle,
                            trailingIcon: Icons.chevron_right,
                            destinationScreen: Placeholder(),
                          ),
                          const AccountTile(
                            accountName: 'Password Change',
                            leadingIcon: Icons.lock_clock,
                            trailingIcon: Icons.chevron_right,
                            destinationScreen: Placeholder(),
                          ),
                          const AccountTile(
                            accountName: 'Notifications',
                            leadingIcon: Icons.notifications,
                            trailingIcon: Icons.chevron_right,
                            destinationScreen: Notifications_view(),
                          ),
                          AccountTile(
                            accountName: 'Log out',
                            leadingIcon: Icons.logout,
                            trailingIcon: Icons.chevron_right,
                            onPressed: () {
                              loginVM.logout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
