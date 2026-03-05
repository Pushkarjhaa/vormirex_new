import 'dart:math' as dartMath;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/auth/forget_password.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Inject AuthController
  final AuthController _authController = Get.put(AuthController());

  bool _isLogin = true;

  // Login controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  bool _loginPasswordVisible = false;

  // Sign up controllers
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _signupConfirmPasswordController = TextEditingController();
  bool _signupPasswordVisible = false;
  bool _signupConfirmPasswordVisible = false;

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Vortex Logo
              Image.asset(
                'assets/new_logo.png',
                height: screenHeight * 0.15,
                width: screenWidth * 0.3,
              ),

              const SizedBox(height: 18),

              // App name
              const Text(
                'VORMIREX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Your personal AI tutor, unlocking\nyour potential.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // Tab switcher
              _TabSwitcher(
                isLogin: _isLogin,
                onTabChanged: (val) => setState(() => _isLogin = val),
              ),

              const SizedBox(height: 28),

              // Form
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: _isLogin
                    ? _LoginForm(
                        key: const ValueKey('login'),
                        emailController: _loginEmailController,
                        passwordController: _loginPasswordController,
                        passwordVisible: _loginPasswordVisible,
                        onTogglePassword: () => setState(
                          () => _loginPasswordVisible = !_loginPasswordVisible,
                        ),
                        authController: _authController,
                      )
                    : _SignupForm(
                        key: const ValueKey('signup'),
                        nameController: _signupNameController,
                        emailController: _signupEmailController,
                        passwordController: _signupPasswordController,
                        confirmPasswordController:
                            _signupConfirmPasswordController,
                        passwordVisible: _signupPasswordVisible,
                        confirmPasswordVisible: _signupConfirmPasswordVisible,
                        onTogglePassword: () => setState(
                          () =>
                              _signupPasswordVisible = !_signupPasswordVisible,
                        ),
                        onToggleConfirmPassword: () => setState(
                          () => _signupConfirmPasswordVisible =
                              !_signupConfirmPasswordVisible,
                        ),
                        authController: _authController,
                        onSignupSuccess: () => setState(() => _isLogin = true),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Tab Switcher ─────────────────────────────────────────────────────────────

class _TabSwitcher extends StatelessWidget {
  final bool isLogin;
  final ValueChanged<bool> onTabChanged;

  const _TabSwitcher({required this.isLogin, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _Tab(
            label: 'Log In',
            isActive: isLogin,
            onTap: () => onTabChanged(true),
          ),
          _Tab(
            label: 'Sign Up',
            isActive: !isLogin,
            onTap: () => onTabChanged(false),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1A4A42) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white54,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Login Form ───────────────────────────────────────────────────────────────

class _LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordVisible;
  final VoidCallback onTogglePassword;
  final AuthController authController;

  const _LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordVisible,
    required this.onTogglePassword,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel('Email Address'),
        const SizedBox(height: 8),
        _InputField(
          controller: emailController,
          hint: 'name@example.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        _FieldLabel('Password'),
        const SizedBox(height: 8),
        _InputField(
          controller: passwordController,
          hint: '••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: !passwordVisible,
          suffixIcon: passwordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: onTogglePassword,
        ),

        const SizedBox(height: 10),

        // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Get.to(() => ForgotPasswordScreen()),
            child: const Text(
              'Forgot Password ?',
              style: TextStyle(
                color: AppColors.accentCyan,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        // Log In button — shows loader while API call is in progress
        Obx(
          () => _PrimaryButton(
            label: 'Log In',
            isLoading: authController.isLoading.value,
            onTap: () => authController.login(
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        ),

        const SizedBox(height: 24),

        _OrDivider(),

        const SizedBox(height: 20),

        _GoogleButton(),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ─── Sign Up Form ─────────────────────────────────────────────────────────────

class _SignupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final AuthController authController;
  final VoidCallback onSignupSuccess;

  const _SignupForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordVisible,
    required this.confirmPasswordVisible,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.authController,
    required this.onSignupSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel('Full Name'),
        const SizedBox(height: 8),
        _InputField(
          controller: nameController,
          hint: 'Enter your name',
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),

        const SizedBox(height: 20),

        _FieldLabel('Email Address'),
        const SizedBox(height: 8),
        _InputField(
          controller: emailController,
          hint: 'name@example.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        _FieldLabel('Password'),
        const SizedBox(height: 8),
        _InputField(
          controller: passwordController,
          hint: '••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: !passwordVisible,
          suffixIcon: passwordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: onTogglePassword,
        ),

        const SizedBox(height: 20),

        _FieldLabel('Confirm Password'),
        const SizedBox(height: 8),
        _InputField(
          controller: confirmPasswordController,
          hint: '••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: !confirmPasswordVisible,
          suffixIcon: confirmPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: onToggleConfirmPassword,
        ),

        const SizedBox(height: 28),

        // Create Account button — shows loader while API call is in progress
        Obx(
          () => _PrimaryButton(
            label: 'Create Account',
            isLoading: authController.isLoading.value,
            onTap: () async {
              await authController.signup(
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
              );
              // Switch to login tab on success (no error means success)
              if (!authController.isLoading.value) {
                onSignupSuccess();
              }
            },
          ),
        ),

        const SizedBox(height: 24),

        _OrDivider(),

        const SizedBox(height: 20),

        _GoogleButton(),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final VoidCallback? onSuffixTap;

  const _InputField({
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 15,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white38, size: 20)
              : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon, color: Colors.white38, size: 20),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentCyan,
          foregroundColor: Colors.black,
          disabledBackgroundColor: AppColors.accentCyan.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white12, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR CONTINUE WITH',
            style: TextStyle(
              color: Colors.white.withOpacity(0.35),
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white12, thickness: 1)),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A4A42),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GoogleIcon(),
            const SizedBox(width: 10),
            const Text(
              'Continue with Google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    final colors = [
      const Color(0xFF4285F4),
      const Color(0xFFEA4335),
      const Color(0xFFFBBC05),
      const Color(0xFF34A853),
    ];

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        i * dartMath.pi / 2,
        dartMath.pi / 2,
        true,
        paint,
      );
    }

    canvas.drawCircle(
      Offset(cx, cy),
      r * 0.55,
      Paint()..color = const Color(0xFF1A4A42),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
