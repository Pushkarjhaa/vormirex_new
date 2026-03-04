import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vormirex_new/view/homescreen.dart';
import 'package:vormirex_new/view/onboarding_first_screen.dart';
import 'package:vormirex_new/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vormirex',
      home: SplashScreen(),
    );
  }
}
