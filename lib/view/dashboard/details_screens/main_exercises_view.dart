import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/excersice_datail.dart'; // Import Get for navigation

class MainExercisesView extends StatelessWidget {
  final List<Exercise> exercises; // Parameter to accept exercises
  final String title;
  const MainExercisesView(
      {super.key, required this.exercises, required this.title}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // App bar title for the exercise list
          title,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: exercises.isEmpty // Check if exercises are empty
            ? const Center(
                child: Text(
                  'No exercises available',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: exercises.length, // Number of exercises
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 20), // Add margin between containers
                    height: 250, // Set the height of the container
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.01),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.5)),
                      image: DecorationImage(
                        image: NetworkImage(
                            exercise.animationUrl), // Use exercise's image
                        fit: BoxFit
                            .cover, // Cover the entire container with the image
                        colorFilter: ColorFilter.mode(
                          Colors.grey.withOpacity(0.3),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Exercise Name
                          Text(
                            exercise.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Equipment and details row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Equipment type
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                  Text(
                                    exercise.equipment,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    exercise.category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              // "TRY" button
                              Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: Container(
                                  height: 40,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        // Navigate to details screen when "TRY" button is pressed
                                        Get.to(() =>
                                            ExerciseDetail(exercise: exercise));
                                      },
                                      child: Text(
                                        "TRY",
                                        style: TextStyle(
                                          color: AppColors.background,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
