import 'dart:math' as dartMath;
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Profile card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: const Color(0xFF0D3330),
                            child: Icon(
                              Icons.person,
                              color: AppColors.accentCyan,
                              size: 36,
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.cardBg,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'user@gmail.com',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(EditProfileScreen());
                        },
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white38,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '75%',
                    style: TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  CyanProgressBar(value: 0.75),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Stats row
            Row(
              children: [
                _StatCard(
                  icon: Icons.local_fire_department,
                  label: '7 Day Streak',
                ),
                const SizedBox(width: 10),
                _StatCard(icon: Icons.local_fire_department, label: 'Courses'),
                const SizedBox(width: 10),
                _StatCard(icon: Icons.local_fire_department, label: 'Learned'),
              ],
            ),

            const SizedBox(height: 16),

            // AI Personalization
            AppCard(
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D3330),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: _MiniVortex()),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AI Personalization',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Learning style: Visual & Interactive',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: const [
                            _SubjectChip('Coding'),
                            _SubjectChip('Python'),
                            _SubjectChip('Mathematics'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Settings
            _SettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Manage Alerts',
              trailing: CyanSwitch(value: true),
            ),
            const SizedBox(height: 10),
            _SettingsTile(
              icon: Icons.translate_outlined,
              title: 'Language',
              subtitle: 'App display language',
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'English',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white38,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _SettingsTile(
              icon: Icons.subscriptions_outlined,
              title: 'Subscription',
              subtitle: 'Pro Plan',
              trailing: CyanSwitch(value: true),
            ),
            const SizedBox(height: 10),
            _SettingsTile(
              icon: Icons.star_outline,
              title: 'Rate App',
              subtitle: 'Share Your Feedback',
              trailing: CyanSwitch(value: true),
            ),

            const SizedBox(height: 12),

            // Log Out
            AppCard(
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0D3330),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.accentCyan, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectChip extends StatelessWidget {
  final String label;
  const _SubjectChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.accentCyan.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: AppColors.accentCyan, fontSize: 11),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white70, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _MiniVortex extends StatelessWidget {
  const _MiniVortex();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: CustomPaint(painter: _MiniVortexPainter()),
    );
  }
}

class _MiniVortexPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final center = Offset(cx, cy);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final arms = [
      [0.0, 2.9, 2.0, 14.0, 2.0],
      [1.26, 2.9, 2.0, 13.0, 1.8],
      [2.51, 2.7, 2.0, 12.0, 1.5],
    ];

    for (final arm in arms) {
      final path = Path();
      for (int i = 0; i <= 40; i++) {
        final t = i / 40;
        final angle = arm[0] + t * arm[1];
        final radius = arm[2] + t * (arm[3] - arm[2]);
        final x = center.dx + radius * dartMath.cos(angle);
        final y = center.dy + radius * dartMath.sin(angle);
        i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
      }
      paint
        ..strokeWidth = arm[4]
        ..color = Colors.white.withOpacity(0.85);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
