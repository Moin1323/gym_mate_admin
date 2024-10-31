import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/repository/user_repository/user_repository.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/res/theme/app_theme.dart';

class EquipmentDetail extends StatelessWidget {
  final Equipment equipment;

  const EquipmentDetail({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    AppThemes.setStatusBarStyle();
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
                equipment.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Image not available',
                      style: TextStyle(color: Colors.white),
                    ),
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
                icon: Icon(Icons.arrow_back,
                    size: 25, color: AppColors.secondary),
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
                      // Equipment Name and Delete Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              equipment.name,
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
                                  title: const Text('Delete Equipment'),
                                  content: const Text(
                                      'Are you sure you want to delete this equipment?'),
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
                                // Call the delete function from UserController
                                Get.find<UserController>().deleteEquipment(equipment
                                    .name); // Replace `equipment.id` with the actual ID property
                                Get.back(); // Go back after deletion
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
                      _infoContainer(equipment),
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

  Widget _infoContainer(Equipment equipment) {
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
          _infoRow(Icons.category, "Category: ${equipment.category}"),
          const SizedBox(height: 10),
          _infoRow(Icons.description, equipment.description),
          const SizedBox(height: 10),

          // Display available sizes if they exist
          if (equipment.availableSizes != null &&
              equipment.availableSizes!.isNotEmpty)
            _infoSizesRow(Icons.view_comfy, equipment.availableSizes!),
        ],
      ),
    );
  }

  // Standard row for details
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
      ],
    );
  }

  // Special row for available sizes
  Widget _infoSizesRow(IconData icon, List<String> sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              "Available Sizes:",
              style: TextStyle(color: AppColors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: sizes.map((size) {
            return Chip(
              label: Text(
                size,
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.primary,
            );
          }).toList(),
        ),
      ],
    );
  }
}
