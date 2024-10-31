import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/equipment_detail.dart';

class EquipmentsList extends StatefulWidget {
  final List<Equipment> equipments; // List of equipment

  const EquipmentsList({super.key, required this.equipments});

  @override
  _EquipmentsListState createState() => _EquipmentsListState();
}

class _EquipmentsListState extends State<EquipmentsList>
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
        title: const Text("Equipments"),
        bottom: TabBar(
          controller: _tabController,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Strength'),
            Tab(text: 'Cardio'),
            Tab(text: 'Boxing'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEquipmentTab('Strength'),
          _buildEquipmentTab('Cardio'),
          _buildEquipmentTab('Boxing'),
        ],
      ),
    );
  }

  Widget _buildEquipmentTab(String category) {
    // Filtering equipment based on the passed category
    final equipments = widget.equipments
            .where((equipment) => equipment.category == category)
            .toList() ??
        [];

    return equipments.isEmpty
        ? Center(
            child: Text(
              'No equipments found',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          )
        : ListView.builder(
            itemCount: equipments.length,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (context, index) {
              final equipment = equipments[index];
              return _buildEquipmentCard(equipment);
            },
          );
  }

  Widget _buildEquipmentCard(Equipment equipment) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EquipmentDetail(equipment: equipment));
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
                equipment.imageUrl,
                fit: BoxFit.cover,
                width: 65,
                height: 65,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 65,
                    height: 65,
                    color: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      Icons.fitness_center,
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
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    equipment.category,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
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
