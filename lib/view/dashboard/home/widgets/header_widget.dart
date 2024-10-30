import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:iconsax/iconsax.dart';

import 'notifications_view.dart';

class HeaderWidget extends StatelessWidget {
  final UserController userController;

  const HeaderWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Obx(() {
            if (userController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              String userName = userController.user.value.name ?? 'User';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, $userName 👨‍💼',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondary.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    'Fitness Freaks.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              );
            }
          }),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(() => const Notifications_view());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  Iconsax.notification,
                  size: 22,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
