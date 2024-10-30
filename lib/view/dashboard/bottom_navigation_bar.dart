import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/view/dashboard/add/add_view.dart';
import 'package:iconsax/iconsax.dart';

import 'settings/settings_view.dart';
import 'home/home_view.dart';

class BottomNavigationbar extends StatefulWidget {
  const BottomNavigationbar({super.key});

  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}

class HomeController extends GetxController {
  var currentIndex = 0.obs; // Observable variable for current index

  // Method to change the index
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  // Instantiate HomeController
  final HomeController homeController = Get.put(HomeController());

  // List of screens
  final List<Widget> _screens = [
    const HomeView(),
    const AddView(),
    const SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _screens[
            homeController.currentIndex.value]; // Display the selected screen
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.setting),
              label: '',
            ),
          ],
          currentIndex: homeController
              .currentIndex.value, // Current index from HomeController
          selectedItemColor:
              const Color(0xFFA3EC3E), // Color for the selected item
          unselectedItemColor: Colors.white, // Color for unselected items
          backgroundColor: const Color(
              0xFF000000), // Background color of the Bottom Navigation Bar
          onTap: (index) {
            homeController.changeIndex(index); // Change index when tapped
          },
          type: BottomNavigationBarType.fixed,
        );
      }),
    );
  }
}
