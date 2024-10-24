import 'package:flutter/material.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';

class TabrComponent extends StatelessWidget {
  final IconData icon; // Image asset path
  final String label; // Text label for the tab

  const TabrComponent({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24, // Background color for the container
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    icon,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                label, // Use the label parameter
                style: TextStyle(
                  color: AppColors.secondary, // Text color
                  fontSize: 15, // Font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
