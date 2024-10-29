import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:gym_mate_admin/res/routes/routes_name.dart';
import 'package:gym_mate_admin/view/auth/login/login_view.dart';
import 'package:gym_mate_admin/view/auth/signup/signup_view.dart';
import 'package:gym_mate_admin/view/dashboard/bottom_navigation_bar.dart';
import 'package:gym_mate_admin/view/splash/splash_view.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splashScreen,
          page: () => const SplashView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.loginView,
          page: () => const LoginView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.loginView,
          page: () => const SignupView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.bottomNavigationBar,
          page: () => const BottomNavigationbar(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
