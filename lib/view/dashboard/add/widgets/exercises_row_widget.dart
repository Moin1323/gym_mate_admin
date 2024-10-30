import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/excersice_datail.dart';

class ExercisesRowWidget extends StatefulWidget {
  final UserController userController;
  final List<Exercise> cardio; // Cardio exercises list
  final List<Exercise> gym; // Gym exercises list
  final List<Exercise> boxing; // Boxing exercises list

  const ExercisesRowWidget({
    super.key,
    required this.userController,
    required this.cardio,
    required this.gym,
    required this.boxing,
  });

  @override
  State<ExercisesRowWidget> createState() => _ExercisesRowWidgetState();
}

class _ExercisesRowWidgetState extends State<ExercisesRowWidget> {
  @override
  Widget build(BuildContext context) {
    // Combine the three lists into a single list
    List<Exercise> combinedExercises = [
      ...widget.cardio,
      ...widget.gym,
      ...widget.boxing,
    ];

    return Column(
      children: [
        // Popular Exercise Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Popular Exercises",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            TextButton(
              onPressed: () {
                // Add edit functionality here
              },
              child: Text("Edit",
                  style: TextStyle(fontSize: 14, color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: combinedExercises.length, // Use the combined list length
            itemBuilder: (context, index) {
              final exercise =
                  combinedExercises[index]; // Get the current exercise
              return GestureDetector(
                onTap: () {
                  // Navigate to ExerciseDetail screen
                  Get.to(() => ExerciseDetail(exercise: exercise));
                },
                child: Container(
                  width: 240,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      // Image as background
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          exercise.animationUrl,
                          width: 240,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Text('Image not available'));
                          },
                        ),
                      ),
                      // Text overlay
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.black54, // Background color for text
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            exercise.name, // Actual exercise name
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            exercise.category, // Actual duration
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            exercise.muscleGroup, // Actual calories
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
