import 'package:flutter/material.dart';

// Onboarding screens are commented out — app navigates directly to AuthScreen

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold();
}

/*
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/auth/auth_screen.dart';
import 'package:vormirex_new/view/onboarding_second_screen.dart';

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Skip', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 260, height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [AppColors.accentCyan.withOpacity(0.08), Colors.transparent]),
                        ),
                      ),
                      Image.asset("assets/onboarding_third_image.png"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Instant AI Guidance', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
                    const SizedBox(height: 16),
                    Text('Stuck on a problem? Your Vormirix AI tutor is available 24/7 to explain complex topics and guide you to the solution', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 15, height: 1.6)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Dot(isActive: false, accentCyan: AppColors.accentCyan),
                      const SizedBox(width: 6),
                      _Dot(isActive: true, accentCyan: AppColors.accentCyan),
                      const SizedBox(width: 6),
                      _Dot(isActive: false, accentCyan: AppColors.accentCyan),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () { Get.to(() => const AuthScreen()); },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentCyan, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)), elevation: 0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.black, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dot(Color c) => Container(
  width: 6, height: 6,
  margin: const EdgeInsets.only(right: 3),
  decoration: BoxDecoration(color: c, shape: BoxShape.circle),
);

class _Dot extends StatelessWidget {
  final bool isActive;
  final Color accentCyan;
  const _Dot({required this.isActive, required this.accentCyan});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8, height: 8,
      decoration: BoxDecoration(color: isActive ? accentCyan : Colors.white24, borderRadius: BorderRadius.circular(4)),
    );
  }
}
*/
