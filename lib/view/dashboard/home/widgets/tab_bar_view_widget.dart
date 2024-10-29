import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/equipment_component.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/exercise_component.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/user_component.dart';

class TabBarViewWidget extends StatelessWidget {
  final UserController userController;

  const TabBarViewWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
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
                isLoading: userController.isLoading.value,
              ),

              // Second Tab - List of equipment
              EquipmentTab(
                equipments: userController.equipments ?? [],
                isLoading: userController.isLoading.value,
              ),

              // Third Tab - List of popular exercises
              PopularTrainings(
                cardio: userController.exercises['cardio'] ?? [],
                boxing: userController.exercises['boxing'] ?? [],
                gym: userController.exercises['gym'] ?? [],
                isLoading: userController.isLoading.value,
                title: 'Cardio',
              ),
            ],
          );
        }
      }),
    );
  }
}
