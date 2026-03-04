import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/auth/auth_screen.dart';

// ─── Create New Password Screen ───────────────────────────────────────────────

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  // Requirements state (updates as user types)
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final pw = _newPasswordController.text;
    setState(() {
      _hasMinLength = pw.length >= 8;
      _hasUppercase = pw.contains(RegExp(r'[A-Z]'));
      _hasNumber = pw.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = pw.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Key icon with glow
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0D3330),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentCyan.withOpacity(0.25),
                        blurRadius: 32,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.key_outlined,
                    color: AppColors.accentCyan,
                    size: 38,
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // Title
              const Text(
                'Create New Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              Text(
                'Your new password must be different\nfrom previous ones',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // Password fields + requirements card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // New Password
                    _PasswordField(
                      controller: _newPasswordController,
                      hint: 'New Password',
                      isVisible: _newPasswordVisible,
                      onToggle: () => setState(
                        () => _newPasswordVisible = !_newPasswordVisible,
                      ),
                      showBottomBorder: true,
                    ),

                    // Confirm Password
                    _PasswordField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm Password',
                      isVisible: _confirmPasswordVisible,
                      onToggle: () => setState(
                        () =>
                            _confirmPasswordVisible = !_confirmPasswordVisible,
                      ),
                      showBottomBorder: true,
                    ),

                    // Requirements
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password requirements:',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.45),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _Requirement(
                            label: 'At least 8 characters',
                            met: _hasMinLength,
                          ),
                          const SizedBox(height: 6),
                          _Requirement(
                            label: 'One uppercase letter',
                            met: _hasUppercase,
                          ),
                          const SizedBox(height: 6),
                          _Requirement(label: 'One number', met: _hasNumber),
                          const SizedBox(height: 6),
                          _Requirement(
                            label: 'One special character',
                            met: _hasSpecialChar,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Reset Password button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PasswordResetSuccessScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentCyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
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
  final String hint;
  final bool isVisible;
  final VoidCallback onToggle;
  final bool showBottomBorder;

  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.isVisible,
    required this.onToggle,
    this.showBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showBottomBorder
            ? const Border(bottom: BorderSide(color: Colors.white10, width: 1))
            : null,
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.35),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.white38,
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}

// ─── Requirement Row ──────────────────────────────────────────────────────────

class _Requirement extends StatelessWidget {
  final String label;
  final bool met;

  const _Requirement({required this.label, required this.met});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle_outline : Icons.cancel_outlined,
          size: 16,
          color: met ? AppColors.accentCyan : Colors.white30,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: met ? Colors.white70 : Colors.white30,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// ─── Password Reset Success Screen ────────────────────────────────────────────

class PasswordResetSuccessScreen extends StatefulWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  State<PasswordResetSuccessScreen> createState() =>
      _PasswordResetSuccessScreenState();
}

class _PasswordResetSuccessScreenState extends State<PasswordResetSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnim = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Animated checkmark with floating bubbles
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: Transform.scale(
                      scale: _scaleAnim.value,
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer glow
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentCyan.withOpacity(0.05),
                        ),
                      ),

                      // Floating bubbles
                      Positioned(top: 10, left: 40, child: _Bubble(size: 14)),
                      Positioned(top: 30, right: 20, child: _Bubble(size: 20)),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: _Bubble(size: 12),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 35,
                        child: _Bubble(size: 10),
                      ),

                      // Main circle
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF0D3330),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentCyan.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_circle_outline_rounded,
                          color: AppColors.accentCyan,
                          size: 42,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Title
              FadeTransition(
                opacity: _fadeAnim,
                child: const Text(
                  'Update Successful',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              FadeTransition(
                opacity: _fadeAnim,
                child: Text(
                  "Password fixed. Let's vibe",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // Go to Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to auth screen
                    Get.offAll(AuthScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentCyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Go to Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Floating Bubble ──────────────────────────────────────────────────────────

class _Bubble extends StatelessWidget {
  final double size;
  const _Bubble({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF0D3330),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentCyan.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
