import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';

class UserDetailsTab extends StatelessWidget {
  final List<UserModel> users;
  final bool isLoading;
  final String title = "Users";

  const UserDetailsTab({
    super.key,
    required this.users,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.01),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "User List 📋",
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold, // Changed to AppColors.secondary
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.005),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // Keeping blue for loading indicator
                ),
              )
            : Container(
                height: Get.height * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: users.map((user) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.02),
                        child:
                            _buildUserCard(context, user), // Pass context here
                      );
                    }).toList(),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context, UserModel user) {
    return GestureDetector(
      onTap: () {
        // Navigate to UserDetail screen
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.25), // Background color
          borderRadius: BorderRadius.circular(15), // Border radius for the card
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60, // Set a width for the icon container
              height: 60, // Set a height for the icon container
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15), // Match card radius
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Match card radius
                child: Icon(Icons.person,
                    color: AppColors.background), // Default icon
              ),
            ),
            SizedBox(width: Get.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? 'No name',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email ?? 'No email',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            // Trailing icon with popup menu
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == 'delete') {
                  _showConfirmationDialog(
                    context, // Use the correct context here
                    title: 'Delete Account',
                    content: 'Are you sure you want to delete your account?',
                    onConfirm: () {
                      _deleteUser(user);
                    },
                  );
                } else if (value == 'deactivate') {
                  _showConfirmationDialog(
                    context, // Use the correct context here
                    title: 'Deactivate Account',
                    content:
                        'Are you sure you want to deactivate your account?',
                    onConfirm: () {
                      _deactivateUser(user);
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 10),
                        Text('Delete'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'deactivate',
                    child: Row(
                      children: [
                        Icon(Icons.block, color: Colors.orange),
                        SizedBox(width: 10),
                        Text('Deactivate'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context,
      {required String title,
      required String content,
      required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                onConfirm(); // Call the confirmation action
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(UserModel user) {
    // Logic to delete the user
    print("Deleting user: ${user.name}");
  }

  void _deactivateUser(UserModel user) {
    // Logic to deactivate the user
    print("Deactivating user: ${user.name}");
  }
}
