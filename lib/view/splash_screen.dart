import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/main_screen.dart';
import 'package:vormirex_new/view/onboarding_first_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Put controller here so onInit() loads prefs immediately
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final bool loggedIn = await _authController.isLoggedIn();

    if (loggedIn) {
      // Token exists → go straight to Home
      Get.offAll(() => const MainScreen());
    } else {
      // No token → show Onboarding
      Get.offAll(() => const OnboardingFirstScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo image
            Image.asset(
              'assets/new_logo.png',
              height: screenHeight * 0.15,
              width: screenWidth * 0.3,
            ),

            const SizedBox(height: 16),

            // App name
            const Text(
              'VORMIREX',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 6,
                height: 1,
              ),
            ),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'Personalised Learning AI',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 15,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
