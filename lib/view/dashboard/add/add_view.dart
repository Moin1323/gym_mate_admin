import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/add/widgets/equipments_row_widget.dart';
import 'package:gym_mate_admin/view/dashboard/add/widgets/exercises_row_widget.dart';
import 'package:gym_mate_admin/view/dashboard/add/widgets/search_container.dart';
import 'package:gym_mate_admin/view/dashboard/add/widgets/users_row_widget.dart';

class AddView extends StatefulWidget {
  final UserController userController;
  const AddView({
    super.key,
    required this.userController,
  });

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.fetchAllUsers();
    userController.fetchAllExercises();
    userController.fetchAllEquipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 10),
              child: Row(
                children: [
                  Search_Conatiner(),
                ],
              ),
            ),
            UsersRowWidget(userController: widget.userController),
            const SizedBox(height: 24),
            ExercisesRowWidget(
              userController: userController,
              cardio: userController.exercises['cardio'] ?? [],
              boxing: userController.exercises['boxing'] ?? [],
              gym: userController.exercises['gym'] ?? [],
            ),
            const SizedBox(height: 24),
            EquipmentsRowWidget(
              equipments: userController.equipments ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
