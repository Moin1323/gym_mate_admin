import 'package:flutter/material.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/home/widgets/tb_component.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
      dividerColor: Colors.transparent,
      indicatorColor: AppColors.primary,
      tabs: const [
        TabrComponent(
          label: 'Users',
          imageAsset: 'lib/assets/images/cardio2.png',
        ),
        TabrComponent(
          label: 'Gear',
          imageAsset: 'lib/assets/images/dumbbell.png',
        ),
        TabrComponent(
          label: 'Fitness',
          imageAsset: 'lib/assets/images/boxing.png',
        ),
      ],
    );
  }
}
