import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/res/components/lists/users_list.dart';

class UsersRowWidget extends StatefulWidget {
  final UserController userController;

  const UsersRowWidget({super.key, required this.userController});

  @override
  State<UsersRowWidget> createState() => _UsersRowWidgetState();
}

class _UsersRowWidgetState extends State<UsersRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Users Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Users",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Add edit functionality here
                Get.to(() => UsersList(userController: widget.userController));
              },
              child: Text(
                "Edit",
                style: TextStyle(fontSize: 14, color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: Obx(() {
            // Use Obx to reactively update the widget
            final users = widget.userController
                .usersList; // Access the users list from the controller
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length, // Use actual user count
              itemBuilder: (context, index) {
                final user = users[index]; // Get the user at the current index
                return Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Text(
                            user.name?.toUpperCase() ??
                                'No name', // Display user's name
                            style: TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                          Text(
                            user.email ?? 'No email', // Display user's name
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 8,
                            ),
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
