import 'package:flutter/material.dart';

// Onboarding screens are commented out — app navigates directly to AuthScreen

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold();
}

/*
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/onboarding_second_screen.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Illustration area
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
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.accentCyan.withOpacity(0.08),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Image.asset("assets/onboarding_image.png"),
                    ],
                  ),
                ),
              ),
            ),

            // Text content
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Instant AI Guidance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Stuck on a problem? Your Vormirix AI tutor is available 24/7 to explain complex topics and guide you to the solution',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.65),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Page indicator + Next button
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
                      onPressed: () {
                        Get.to(OnboardingSecondScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentCyan,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
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

// ─── Illustration sub-widgets ────────────────────────────────────────────────

class _StudentFigure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 160,
      child: CustomPaint(painter: _StudentPainter()),
    );
  }
}

class _StudentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    const skin = Color(0xFFE8A87C);
    const shirt = Color(0xFF7EC8A0);
    paint.color = shirt;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(20, 80, 55, 70), const Radius.circular(10)), paint);
    paint.color = skin;
    canvas.drawOval(Rect.fromLTWH(25, 30, 45, 52), paint);
    paint.color = const Color(0xFF2C1810);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(23, 28, 47, 25), const Radius.circular(20)), paint);
    paint.color = skin;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 110, 30, 18), const Radius.circular(8)), paint);
    paint.color = skin;
    canvas.drawOval(Rect.fromLTWH(22, 74, 20, 18), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AIFigure extends StatelessWidget {
  final Color accentCyan;
  const _AIFigure({required this.accentCyan});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 170,
      child: CustomPaint(painter: _AIPainter(accentCyan: accentCyan)),
    );
  }
}

class _AIPainter extends CustomPainter {
  final Color accentCyan;
  const _AIPainter({required this.accentCyan});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = const Color(0xFF6B5CE7);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(10, 85, 60, 75), const Radius.circular(12)), paint);
    paint.color = const Color(0xFF5A4BD1);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(15, 100, 50, 14), const Radius.circular(4)), paint);
    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    glowPaint.color = accentCyan.withOpacity(0.4);
    canvas.drawCircle(const Offset(40, 52), 34, glowPaint);
    paint.color = accentCyan.withOpacity(0.9);
    canvas.drawCircle(const Offset(40, 52), 26, paint);
    paint.color = const Color(0xFF003333);
    canvas.drawOval(Rect.fromLTWH(27, 43, 10, 14), paint);
    canvas.drawOval(Rect.fromLTWH(43, 43, 10, 14), paint);
    paint.color = const Color(0xFF6B5CE7);
    final path = Path()
      ..moveTo(68, 100)
      ..lineTo(80, 75)
      ..lineTo(75, 72)
      ..lineTo(62, 95)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FloatingCard extends StatelessWidget {
  final Color accentCyan;
  const _FloatingCard({required this.accentCyan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E3E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentCyan.withOpacity(0.25), width: 1),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 6, width: 50, decoration: BoxDecoration(color: accentCyan.withOpacity(0.7), borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 5),
          Container(height: 4, width: 65, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 4),
          Container(height: 4, width: 55, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 4),
          Container(height: 4, width: 60, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(width: 20, height: 20, decoration: BoxDecoration(color: accentCyan.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.person, size: 12, color: accentCyan)),
              const SizedBox(width: 4),
              Container(width: 20, height: 20, decoration: BoxDecoration(color: accentCyan.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.bar_chart, size: 12, color: accentCyan)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LaptopWidget extends StatelessWidget {
  final Color accentCyan;
  const _LaptopWidget({required this.accentCyan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 130,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            border: Border.all(color: Colors.white12, width: 1.5),
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [_dot(Colors.red), _dot(Colors.orange), _dot(Colors.green)]),
              const SizedBox(height: 4),
              Container(height: 3, color: accentCyan.withOpacity(0.5)),
              const SizedBox(height: 3),
              Container(height: 3, color: Colors.white12),
              const SizedBox(height: 3),
              Container(height: 3, width: 60, color: Colors.white12),
            ],
          ),
        ),
        Container(
          width: 150,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF3A3A4A),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
          ),
        ),
      ],
    );
  }

  Widget _dot(Color c) => Container(
    width: 6,
    height: 6,
    margin: const EdgeInsets.only(right: 3),
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

class _Dot extends StatelessWidget {
  final bool isActive;
  final Color accentCyan;
  const _Dot({required this.isActive, required this.accentCyan});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? accentCyan : Colors.white24,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
*/
