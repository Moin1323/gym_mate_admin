import 'package:flutter/material.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/add/widgets/search_container.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
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
            // Users Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Users",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                TextButton(
                  onPressed: () {
                    // Add edit functionality here
                  },
                  child: Text("Edit",
                      style: TextStyle(fontSize: 14, color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Replace with actual user count
                itemBuilder: (context, index) {
                  return Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(height: 8),
                        Text("User Name",
                            style: TextStyle(color: AppColors.background)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Popular Exercise Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Popular Exercises",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                TextButton(
                  onPressed: () {
                    // Add edit functionality here
                  },
                  child: Text("Edit",
                      style: TextStyle(fontSize: 14, color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Replace with actual exercise count
                itemBuilder: (context, index) {
                  return Container(
                    width: 240,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Exercise Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Duration",
                                  style: TextStyle(color: Colors.white70)),
                              Text("Calories",
                                  style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Equipments Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Equipments",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                TextButton(
                  onPressed: () {
                    // Add edit functionality here
                  },
                  child: Text("Edit",
                      style: TextStyle(fontSize: 14, color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Replace with actual equipment count
                itemBuilder: (context, index) {
                  return Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fitness_center,
                            size: 40, color: Colors.white),
                        SizedBox(height: 8),
                        Text("Equipment",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
