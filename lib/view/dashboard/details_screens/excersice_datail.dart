import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/res/theme/app_theme.dart';

class ExerciseDetail extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetail({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    AppThemes.setStatusBarStyle();

    final UserController userController =
        Get.find(); // Get the instance of UserController

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Top Image Section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Image.network(
                exercise.animationUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('Image not available',
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, size: 25, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),

          // DraggableScrollableSheet for the scrollable bottom container
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.55,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Exercise Name and Delete Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              exercise.name,
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // Show a confirmation dialog before deletion
                              bool? confirmDelete = await Get.dialog<bool>(
                                AlertDialog(
                                  title: const Text('Delete Exercise'),
                                  content: const Text(
                                      'Are you sure you want to delete this exercise?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(result: false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Get.back(result: true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmDelete == true) {
                                // Call deleteExercise method from UserController
                                await userController.deleteExercise(
                                    exercise.category, exercise.name);
                                Get.back(); // Optionally go back after deletion
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Dynamic info container for all details
                      _infoContainer(exercise),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoContainer(Exercise exercise) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Icons.category, "Category: ${exercise.category}"),
          const SizedBox(height: 10),
          _infoRow(Icons.emoji_flags, "Difficulty: ${exercise.difficulty}"),
          const SizedBox(height: 10),
          _infoRow(Icons.sports_gymnastics, "Equipment: ${exercise.equipment}"),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(color: AppColors.secondary)),
      ],
    );
  }
}
