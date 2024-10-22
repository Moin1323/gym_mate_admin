import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';

class AccountTile extends StatelessWidget {
  final String accountName;
  final IconData leadingIcon;
  final IconData? trailingIcon;
  final bool showSwitch; // Determines whether to show a switch or an icon
  final Widget? destinationScreen; // Optional destination screen

  const AccountTile({
    super.key,
    required this.accountName,
    required this.leadingIcon,
    this.trailingIcon,
    this.showSwitch = false,
    this.destinationScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color:
              AppColors.background, // Background color of the parent container
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          onTap: () {
            if (destinationScreen != null) {
              // Navigate only if destinationScreen is not null
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationScreen!),
              );
            } else {
              // Optionally show a message if there's no destination
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No destination specified.')),
              );
            }
          },
          title: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.1,
                  height: Get.height * 0.04,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      leadingIcon,
                      size: 25,
                      color: AppColors.background,
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.039),
                Expanded(
                  child: Text(
                    accountName,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                // Show CupertinoSwitch if showSwitch is true, otherwise show the Icon
                if (showSwitch)
                  Transform.scale(
                    scale:
                        0.8, // Adjust this value to increase or decrease the size
                    child: CupertinoSwitch(
                      value: true,
                      activeColor: AppColors
                          .primary, // Set the initial value of the switch as needed
                      onChanged: (bool value) {
                        // Add your onChanged functionality here
                      },
                    ),
                  )
                else
                  Icon(
                    trailingIcon,
                    size: 25,
                    color: AppColors.secondary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
