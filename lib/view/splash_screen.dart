import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/main_screen.dart';
import 'package:vormirex_new/view/auth/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      Get.offAll(() => const MainScreen());
    } else {
      Get.offAll(() => const AuthScreen());
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // ClipRect trims the transparent bottom padding of the PNG
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                // heightFactor controls how much of the image height is kept.
                // Lower value = more bottom whitespace cropped.
                // Adjust between 0.6 – 0.85 to taste.
                heightFactor: 0.70,
                child: Image.asset(
                  'assets/new_logo.png',
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // App name — sits tight below the logo
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
