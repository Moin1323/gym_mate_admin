import 'package:get/get.dart';
import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:gym_mate_admin/res/routes/routes_name.dart';
import 'package:gym_mate_admin/view_models/controller/user_preferences/user_preferences_view_model.dart';

class SplashServices {
  UserPreferences userPreferences = UserPreferences();

  void isLogin() async {
    try {
      UserModel user = await userPreferences.getUser();
      if (user.token == null || user.token!.isEmpty) {
        print("User token is null or empty. Navigating to login.");
        Get.offNamed(RoutesName.loginView);
      } else {
        print("User token found. Navigating to home.");
        Get.offNamed(RoutesName.homeView);
      }
    } catch (e) {
      print("Error in isLogin: $e");
      Get.offNamed(RoutesName.loginView);
    }
  }
}
