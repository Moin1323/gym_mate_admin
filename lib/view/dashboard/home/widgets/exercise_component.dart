import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/Exercieses/excersice_datail.dart';
import 'package:gym_mate_admin/view/dashboard/Exercieses/main_exercises_view.dart';

class PopularTrainings extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final List<Exercise> cardio; // Cardio exercises list
  final List<Exercise> gym; // Gym exercises list
  final List<Exercise> boxing; // Boxing exercises list
  final String title;
  final bool isLoading;

  PopularTrainings({
    super.key,
    required this.cardio,
    required this.gym,
    required this.boxing,
    required this.isLoading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Combine the three lists into a single list
    List<Exercise> combinedTrainings = [
      ...cardio,
      ...gym,
      ...boxing,
    ];

    return Column(
      children: [
        SizedBox(height: Get.height * 0.01),
        Row(
          children: [
            Text(
              "Exercises 🔥",
              style: TextStyle(
                  color: AppColors.secondary, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.to(() => MainExercisesView(
                    title: title, exercises: combinedTrainings));
              },
              child: const Text(
                'Edit',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.005),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : Container(
                height:
                    Get.height * 0.45, // Set a fixed height for scrollable area
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: combinedTrainings.map((training) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.02),
                        child: _buildTrainingCard(training),
                      );
                    }).toList(),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildTrainingCard(Exercise training) {
    return GestureDetector(
      onTap: () {
        // Navigate to ExerciseDetail screen
        Get.to(() => ExerciseDetail(exercise: training));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.25), // Background color
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                training.animationUrl,
                width: 60, // Fixed width for image
                height: 60, // Fixed height for image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not available'));
                },
              ),
            ),
            SizedBox(width: Get.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    training.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    training.category,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      children: [
        SizedBox(height: Get.height * 0.01),
        Row(
          children: [
            Text(
              "User List 📋",
              style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight:
                      FontWeight.bold), // Changed to AppColors.secondary
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Add your navigation to view all users
              },
              child: const Text(
                'Edit',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold), // Keeping blue for button
              ),
            ),
          ],
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
                        child: _buildUserCard(user),
                      );
                    }).toList(),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildUserCard(UserModel user) {
    return GestureDetector(
      onTap: () {
        // Navigate to UserDetail screen
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color:
              AppColors.secondary.withOpacity(0.25), // Changed background color
          borderRadius:
              BorderRadius.circular(15), // Border radius for the whole card
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60, // Set a width for the icon container
              height: 60, // Set a height for the icon container
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:
                    BorderRadius.circular(15), // Match border radius with card
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Match border radius with card
                child: Icon(Icons.person,
                    color: AppColors.background), // Default icon
              ),
            ),
            SizedBox(width: Get.width * 0.04),
            Column(
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
          ],
        ),
      ),
    );
  }
}

class EquipmentTab extends StatelessWidget {
  final List<Equipment> equipments;
  final bool isLoading;
  final String title = "Equipments";

  const EquipmentTab({
    super.key,
    required this.equipments,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.01),
        Row(
          children: [
            Text(
              "Equipments 🏋️‍♂️",
              style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight:
                      FontWeight.bold), // Changed to AppColors.secondary
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Get.to(() => EquipmentDetailView(equipments: equipments));
              },
              child: const Text(
                'Edit',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold), // Keeping blue for button
              ),
            ),
          ],
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
                height: Get.height * 0.45, // Set height for scrollable area
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: equipments.map((equipment) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.02),
                        child: _buildEquipmentCard(equipment),
                      );
                    }).toList(),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildEquipmentCard(Equipment equipment) {
    return GestureDetector(
      onTap: () {
        // Navigate to EquipmentDetail screen
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color:
              AppColors.secondary.withOpacity(0.25), // Changed background color
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                equipment.imageUrl,
                fit: BoxFit.cover,
                width: 60, // Fixed width for image
                height: 60, // Fixed height for image
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.fitness_center, // Use a fitness-related icon
                      size: 30,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: Get.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    equipment.category,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
