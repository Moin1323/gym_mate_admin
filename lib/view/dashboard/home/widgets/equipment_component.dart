import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/equipment_detail.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.01),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Equipments 🏋️‍♂️",
            style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold), // Changed to AppColors.secondary
          ),
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
                height: Get.height * 0.45, // Set height for scrollable area
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
        Get.to(() => EquipmentDetail(equipment: equipment));
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                equipment.imageUrl,
                fit: BoxFit.cover,
                width: 60, // Fixed width for image
                height: 60, // Fixed height for image
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.fitness_center, // Use a fitness-related icon
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
            ),
          ],
        ),
      ),
    );
  }
}
