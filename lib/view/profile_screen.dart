import 'dart:math' as dartMath;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/controller/change_password_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showChangePasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ChangePasswordSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // ── Profile card ─────────────────────────────────────────────
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
                            Obx(
                              () => Text(
                                authController.userName.value.isNotEmpty
                                    ? authController.userName.value
                                    : 'User Name',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Obx(
                              () => Text(
                                authController.userEmail.value.isNotEmpty
                                    ? authController.userEmail.value
                                    : 'user@gmail.com',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => EditProfileScreen()),
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

            // ── Stats row ────────────────────────────────────────────────
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

            // ── AI Personalization ───────────────────────────────────────
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
                        const Text(
                          'Learning style: Visual & Interactive',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        const Wrap(
                          spacing: 6,
                          children: [
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

            // ── Settings Tiles ───────────────────────────────────────────
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(width: 4),
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

            const SizedBox(height: 10),

            // ── Change Password ──────────────────────────────────────────
            GestureDetector(
              onTap: () => _showChangePasswordSheet(context),
              child: AppCard(
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.accentCyan.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        color: AppColors.accentCyan,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Update your account password',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white24,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ── Log Out ──────────────────────────────────────────────────
            GestureDetector(
              onTap: () => authController.logout(),
              child: AppCard(
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
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// ─── Change Password Sheet (StatefulWidget) ───────────────────────────────────
// Using StatefulWidget so TextEditingControllers are managed by Flutter,
// not GetX. This prevents the "used after disposed" crash entirely.

class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet();

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  // ✅ Owned and disposed by this State — not by GetX
  final _oldCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _oldCtrl.dispose();
    _newCtrl.dispose();
    super.dispose();
  }

  bool _validate(String oldPass, String newPass) {
    if (oldPass.isEmpty || newPass.isEmpty) {
      _showError('Please fill in all fields.');
      return false;
    }
    if (newPass.length < 6) {
      _showError('New password must be at least 6 characters.');
      return false;
    }
    if (oldPass == newPass) {
      _showError('New password must differ from current password.');
      return false;
    }
    return true;
  }

  Future<void> _submit() async {
    // ✅ Read BEFORE any async — widget might unmount during await
    final oldPass = _oldCtrl.text.trim();
    final newPass = _newCtrl.text.trim();

    if (!_validate(oldPass, newPass)) return;

    if (mounted) setState(() => _isLoading = true);

    final ctrl = Get.put(ChangePasswordController());
    await ctrl.changePassword(
      oldPassword: oldPass,
      newPassword: newPass,
      onSuccess: (message) {
        if (!mounted) return;
        // ✅ Close sheet — State is still mounted here
        Navigator.of(context).pop();
        // ✅ Show snackbar after sheet is gone
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            'Success ✓',
            message,
            backgroundColor: AppColors.accentCyan.withOpacity(0.15),
            colorText: AppColors.accentCyan,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            duration: const Duration(seconds: 3),
          );
        });
      },
      onError: (message) {
        if (mounted) setState(() => _isLoading = false);
        _showError(message);
      },
    );

    // Clean up controller after use
    if (Get.isRegistered<ChangePasswordController>()) {
      Get.delete<ChangePasswordController>();
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.withOpacity(0.15),
      colorText: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ AnimatedPadding responds to keyboard open/close smoothly
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A1F1E),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: Colors.white10),
        ),
        // ✅ SingleChildScrollView prevents overflow when keyboard appears
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Update your account password below.',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
              const SizedBox(height: 24),

              // Old Password
              _PasswordField(
                controller: _oldCtrl,
                label: 'Old Password',
                obscure: _obscureOld,
                onToggle: () => setState(() => _obscureOld = !_obscureOld),
              ),
              const SizedBox(height: 14),

              // New Password
              _PasswordField(
                controller: _newCtrl,
                label: 'New Password',
                obscure: _obscureNew,
                onToggle: () => setState(() => _obscureNew = !_obscureNew),
              ),
              const SizedBox(height: 24),

              // ✅ setState drives the button — no GetX widget needed here
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentCyan,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: AppColors.accentCyan.withOpacity(
                      0.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Update Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Password Field ───────────────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.label,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.accentCyan, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.white38,
            size: 20,
          ),
          onPressed: onToggle,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────

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

// ─── Subject Chip ─────────────────────────────────────────────────────────────

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

// ─── Settings Tile ────────────────────────────────────────────────────────────

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
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
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

// ─── Mini Vortex ──────────────────────────────────────────────────────────────

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
