import 'package:flutter/material.dart';

class TabrComponent extends StatelessWidget {
  final String imageAsset; // Image asset path
  final String label; // Text label for the tab

  const TabrComponent({
    super.key,
    required this.imageAsset,
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
              CircleAvatar(
                backgroundColor:
                    Colors.white10, // Background color for the avatar
                radius: 12, // Size of the CircleAvatar
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      imageAsset, // Use the imageAsset parameter
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                label, // Use the label parameter
                style: const TextStyle(
                  color: Colors.white, // Text color
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
