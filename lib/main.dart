import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/res/getx_localization/languages.dart';
import 'package:gym_mate_admin/res/routes/app_routes.dart';
import 'package:gym_mate_admin/res/theme/theme_controller.dart';
import 'package:gym_mate_admin/view/splash/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the ThemeController
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Access the ThemeController
    final ThemeController themeController = Get.find();

    return Obx(
      () => GetMaterialApp(
        title: 'Flutter Demo',
        translations: Languages(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), // Define your light theme
        darkTheme: ThemeData.dark(), // Define your dark theme
        themeMode: themeController.themeMode.value, // Set theme mode
        home: const SplashView(),
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}
