import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
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
            const Text(
              "Popular Trainings 🔥",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.to(() =>
                    MainExercisesView(title: title, exercises: trainings));
              },
              child: const Text(
                'See all',
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
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: trainings.map((training) {
                    return Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.04),
                      child: _buildTrainingCard(training),
                    );
                  }).toList(),
                ),
              ),
      ],
    );
  }

  // Helper method to build individual training cards
  Widget _buildTrainingCard(Exercise training) {
    return GestureDetector(
      onTap: () {
        // Navigate to ExerciseDetail screen
        Get.to(() => ExerciseDetail(exercise: training));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: Get.height * 0.30,
              width: Get.width * 0.70,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Image.network(
                training.animationUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not available'));
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: Get.height * 0.30,
              width: Get.width * 0.70,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      training.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text(
                      training.category,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
