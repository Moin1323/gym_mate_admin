import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/res/components/lists/equipments_list.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/equipment_detail.dart';

class EquipmentsRowWidget extends StatelessWidget {
  final List<Equipment> equipments; // List of equipment

  const EquipmentsRowWidget({
    super.key,
    required this.equipments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Equipments Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Equipments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Add edit functionality here
                Get.to(() => EquipmentsList(equipments: equipments));
              },
              child: Text(
                "Edit",
                style: TextStyle(fontSize: 14, color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: equipments.length, // Use actual equipment count
            itemBuilder: (context, index) {
              final equipment = equipments[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to EquipmentDetail screen
                  Get.to(() => EquipmentDetail(equipment: equipment));
                },
                child: Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          equipment.imageUrl,
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.fitness_center,
                                size: 40,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color:
                                Colors.black54, // Semi-transparent background
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          equipment.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
