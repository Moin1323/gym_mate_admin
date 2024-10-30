import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/excersice_datail.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.01),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Exercises 🔥",
            style: TextStyle(
                color: AppColors.secondary, fontWeight: FontWeight.bold),
          ),
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
          borderRadius: BorderRadius.circular(20),
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
