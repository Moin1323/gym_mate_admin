import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';

class UsersList extends StatefulWidget {
  final UserController userController;

  const UsersList({super.key, required this.userController});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Obx(() {
          final users = widget.userController
              .usersList; // Access the users list from the controller
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Show 2 cards per row
              childAspectRatio: 0.85, // Adjust aspect ratio to fit the design
              crossAxisSpacing: 16.0, // Increased spacing between cards
              mainAxisSpacing: 16.0, // Increased spacing between cards
            ),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index]; // Get the user at the current index
              return _buildUserCard(user);
            },
          );
        }),
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Added padding inside the card
      decoration: BoxDecoration(
        color:
            AppColors.primary, // Use a different color for the card background
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Darker shadow for depth
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 70, // Slightly larger icon
            color: AppColors.secondary,
          ),
          const SizedBox(height: 12), // Increased spacing below icon
          Text(
            user.name?.toUpperCase() ?? 'No name', // Display user's name
            style: TextStyle(
              color:
                  AppColors.background, // Changed to primary color for contrast
              fontWeight: FontWeight.bold,
              fontSize: 16, // Increased font size
            ),
            overflow: TextOverflow.ellipsis, // Handle overflow
            textAlign: TextAlign.center, // Center align the text
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? 'No email', // Display user's email
            style: TextStyle(
              color: AppColors
                  .background, // Changed to a secondary color for better readability
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis, // Handle overflow
            textAlign: TextAlign.center, // Center align the text
          ),
        ],
      ),
    );
  }
}
