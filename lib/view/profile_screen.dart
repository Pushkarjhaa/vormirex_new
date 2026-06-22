import 'dart:math' as dartMath;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/controller/change_password_controller.dart';
import 'package:vormirex_new/controller/profile_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
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

    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    final ProfileController profileController = Get.find<ProfileController>();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────
            _ProfileHeader(profileController: profileController),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // ── Profile Info ────────────────────────────────────────
                  _ProfileInfo(
                    authController: authController,
                    profileController: profileController,
                  ),

                  const SizedBox(height: 22),

                  // ── Stats Row ───────────────────────────────────────────
                  const _StatsRow(),

                  const SizedBox(height: 16),

                  // ── Edit Profile + Share ────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.to(() => const EditProfileScreen()),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3CD9C3), Color(0xFF2BBFA9)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit_outlined,
                                    color: Colors.black, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1B2E),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: const Color(0xFF2A2B3D), width: 1),
                        ),
                        child: const Icon(Icons.share_outlined,
                            color: Colors.white70, size: 20),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── Mastered Subjects ───────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mastered Subjects',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          color: AppColors.accentCyan,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 34,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _SubjectChip('Quantum Physics'),
                        SizedBox(width: 8),
                        _SubjectChip('Advanced JS'),
                        SizedBox(width: 8),
                        _SubjectChip('AI Ethics'),
                        SizedBox(width: 8),
                        _SubjectChip('Machine Learning'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Collectibles ────────────────────────────────────────
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Collectibles',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const _CollectiblesGrid(),

                  const SizedBox(height: 24),

                  // ── Change Password ─────────────────────────────────────
                  GestureDetector(
                    onTap: () => _showChangePasswordSheet(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1B2E),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: const Color(0xFF2A2B3D), width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color:
                                  AppColors.accentCyan.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.lock_outline,
                                color: AppColors.accentCyan, size: 20),
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
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Update your account password',
                                  style: TextStyle(
                                      color: Colors.white38, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right,
                              color: Colors.white24, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Log Out ─────────────────────────────────────────────
                  GestureDetector(
                    onTap: () => authController.logout(),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1B2E),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: const Color(0xFF2A2B3D), width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.logout,
                                color: Colors.red, size: 20),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Log Out',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  final ProfileController profileController;
  const _ProfileHeader({required this.profileController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D2828), Color(0xFF0D0D1A)],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          const Text(
            'VORMIREX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Obx(() {
            final photoUrl = profileController.profilePhotoUrl.value;
            return CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF0D3330),
              backgroundImage:
                  photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
              child: photoUrl.isEmpty
                  ? const Icon(Icons.person,
                      color: AppColors.accentCyan, size: 20)
                  : null,
            );
          }),
        ],
      ),
    );
  }
}

// ─── Profile Info ─────────────────────────────────────────────────────────────

class _ProfileInfo extends StatelessWidget {
  final AuthController authController;
  final ProfileController profileController;

  const _ProfileInfo({
    required this.authController,
    required this.profileController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar with cyan border glow
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accentCyan, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentCyan.withValues(alpha: 0.25),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Obx(() {
            final photoUrl = profileController.profilePhotoUrl.value;
            return CircleAvatar(
              radius: 46,
              backgroundColor: const Color(0xFF0D3330),
              backgroundImage:
                  photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
              child: photoUrl.isEmpty
                  ? const Icon(Icons.person,
                      color: AppColors.accentCyan, size: 52)
                  : null,
            );
          }),
        ),

        const SizedBox(height: 14),

        // Name
        Obx(() => Text(
              profileController.name.value.isNotEmpty
                  ? profileController.name.value
                  : authController.userName.value.isNotEmpty
                      ? authController.userName.value
                      : 'User Name',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            )),

        const SizedBox(height: 10),

        // Badges
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _BadgePill('PRO MEMBER'),
            SizedBox(width: 8),
            _BadgePill('ELITE LEARNER'),
          ],
        ),
      ],
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _StatCard(label: 'TOTAL XP', value: '24.5k', icon: Icons.bolt),
        SizedBox(width: 10),
        _StatCard(
            label: 'STREAK',
            value: '12D',
            icon: Icons.local_fire_department),
        SizedBox(width: 10),
        _StatCard(
            label: 'GLOBAL RANK',
            value: '#42',
            icon: Icons.emoji_events_outlined),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1B2E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2A2B3D), width: 1),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Icon(icon, color: AppColors.accentCyan, size: 18),
          ],
        ),
      ),
    );
  }
}

// ─── Badge Pill ───────────────────────────────────────────────────────────────

class _BadgePill extends StatelessWidget {
  final String label;
  const _BadgePill(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF252535),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2A2B3D), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.accentCyan,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─── Collectibles Grid ────────────────────────────────────────────────────────

class _CollectiblesGrid extends StatelessWidget {
  const _CollectiblesGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.88,
      children: const [
        _AchievementCard(
          title: 'Speed Demon',
          description: 'Complete 10 lessons\nunder 3m',
          color: Color(0xFF3CD9C3),
          progress: 0.82,
          icon: Icons.flash_on,
        ),
        _AchievementCard(
          title: 'Night Owl',
          description: 'Study 4 days after\nmidnight',
          color: Color(0xFF4A7FD6),
          progress: 0.5,
          icon: Icons.nightlight_round,
        ),
        _AchievementCard(
          title: 'Perfect Score',
          description: '50 Lessons with 100%',
          color: Color(0xFFF07A3A),
          progress: 0.67,
          icon: Icons.star_outline,
          showProgressBar: true,
          progressText: '60/90',
          progressValue: 0.67,
        ),
        _AchievementCard(
          title: 'Polymath',
          description: 'Master 5 different\nsubjects',
          color: Color(0xFF9B6DD6),
          progress: 0.6,
          icon: Icons.auto_awesome,
          showProgressBar: true,
          progressText: '3/5',
          progressValue: 0.6,
        ),
      ],
    );
  }
}

// ─── Achievement Card ─────────────────────────────────────────────────────────

class _AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final double progress;
  final IconData icon;
  final bool showProgressBar;
  final String progressText;
  final double progressValue;

  const _AchievementCard({
    required this.title,
    required this.description,
    required this.color,
    required this.progress,
    required this.icon,
    this.showProgressBar = false,
    this.progressText = '',
    this.progressValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2B3D), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular progress with icon
          SizedBox(
            width: 54,
            height: 54,
            child: CustomPaint(
              painter: _CircularProgressPainter(
                progress: progress,
                color: color,
              ),
              child: Center(
                child: Icon(icon, color: color, size: 22),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),

          if (showProgressBar) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  progressText,
                  style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Circular Progress Painter ────────────────────────────────────────────────

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _CircularProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -dartMath.pi / 2,
      2 * dartMath.pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter old) =>
      old.progress != progress || old.color != color;
}

// ─── Change Password Sheet ────────────────────────────────────────────────────

class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet();

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
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
        Navigator.of(context).pop();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            'Success ✓',
            message,
            backgroundColor: AppColors.accentCyan.withValues(alpha: 0.15),
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

    if (Get.isRegistered<ChangePasswordController>()) {
      Get.delete<ChangePasswordController>();
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.withValues(alpha: 0.15),
      colorText: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0A1F1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
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
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text(
                'Update your account password below.',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
              const SizedBox(height: 24),
              _PasswordField(
                controller: _oldCtrl,
                label: 'Old Password',
                obscure: _obscureOld,
                onToggle: () =>
                    setState(() => _obscureOld = !_obscureOld),
              ),
              const SizedBox(height: 14),
              _PasswordField(
                controller: _newCtrl,
                label: 'New Password',
                obscure: _obscureNew,
                onToggle: () =>
                    setState(() => _obscureNew = !_obscureNew),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentCyan,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor:
                        AppColors.accentCyan.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.black),
                        )
                      : const Text(
                          'Update Password',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
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
        labelStyle:
            const TextStyle(color: Colors.white38, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
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
          borderSide:
              BorderSide(color: AppColors.accentCyan, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.white38,
            size: 20,
          ),
          onPressed: onToggle,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
