import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/excersice_datail.dart';

class ExercisesList extends StatefulWidget {
  final UserController userController;

  const ExercisesList({super.key, required this.userController});

  @override
  _ExercisesListState createState() => _ExercisesListState();
}

class _ExercisesListState extends State<ExercisesList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
        bottom: TabBar(
          controller: _tabController,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          tabs: const [
            Tab(
              text: 'Strength',
            ),
            Tab(
              text: 'Cardio',
            ),
            Tab(
              text: 'Boxing',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExerciseTab(widget.userController.exercises['gym'] ?? []),
          _buildExerciseTab(widget.userController.exercises['cardio'] ?? []),
          _buildExerciseTab(widget.userController.exercises['boxing'] ?? []),
        ],
      ),
    );
  }

  Widget _buildExerciseTab(List<Exercise> exercises) {
    return exercises.isEmpty
        ? Center(
            child: Text(
              'No exercises found',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          )
        : ListView.builder(
            itemCount: exercises.length,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return _buildExerciseCard(exercise);
            },
          );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ExerciseDetail(exercise: exercise));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                exercise.animationUrl,
                fit: BoxFit.cover,
                width: 65,
                height: 65,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 65,
                    height: 65,
                    color: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      Icons.fitness_center_rounded,
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
                    exercise.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exercise.category,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Difficulty: ${exercise.difficulty}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
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
