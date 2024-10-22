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
  final List<Exercise> trainings;
  final String title;
  final bool isLoading;

  PopularTrainings({
    super.key,
    required this.trainings,
    required this.isLoading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.01),
        Row(
          children: [
            Text(
              "Most Recent 🔥",
              style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight:
                      FontWeight.bold), // Changed to AppColors.secondary
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.to(() =>
                    MainExercisesView(title: title, exercises: trainings));
              },
              child: const Text(
                ' Edit',
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
                    children: trainings.map((training) {
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
        Get.to(() => ExerciseDetail(exercise: training));
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
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary, // Using AppColors.primary
              backgroundImage: NetworkImage(
                training.animationUrl,
              ),
              onBackgroundImageError: (_, __) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
            SizedBox(width: Get.width * 0.04),
            Column(
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
                'View All',
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
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary, // Using AppColors.primary
                child: Icon(Icons.person,
                    color: AppColors.background)), // Default icon
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
              "Most Recent 🔥",
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
                'View All',
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
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary, // Using AppColors.primary
              child: Icon(Icons.fitness_center,
                  color: AppColors.background), // Default icon
            ),
            SizedBox(width: Get.width * 0.04),
            Column(
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
          ],
        ),
      ),
    );
  }
}
