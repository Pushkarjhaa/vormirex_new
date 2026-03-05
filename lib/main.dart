import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/view/splash_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized before any async work
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPreferences.getInstance();

  // Register AuthController globally so it's available across all screens
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vormirex',
      home: SplashScreen(),
    );
  }
}
