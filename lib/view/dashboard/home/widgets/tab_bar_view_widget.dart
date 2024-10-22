import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/exercise_component.dart';

class TabBarViewWidget extends StatelessWidget {
  final UserController userController;

  const TabBarViewWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    print("Equipment List: ${userController.equipments}");

    return Expanded(
      child: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return TabBarView(
            children: [
              // First Tab - User Details with user icon
              UserDetailsTab(
                users: userController.usersList,
              ),

              // Second Tab - List of equipment
              EquipmentTab(
                equipments: userController.equipments ??
                    [], // Your list of equipment from the controller
                isLoading: userController.isLoading.value,
              ),

              PopularTrainings(
                trainings: userController.exercises['all'] ??
                    [], // Accessing all exercises
                isLoading: userController.isLoading.value,
                title: 'Exercises',
              ),
            ],
          );
        }
      }),
    );
  }
}
