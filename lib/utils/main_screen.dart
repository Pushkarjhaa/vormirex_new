import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/new_home_screen.dart' hide AppColors;
 
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: NewHomeScreen(),
    );
  }
}