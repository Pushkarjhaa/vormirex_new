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
  final AuthController _authController = Get.put(AuthController());

  bool _isLogin = true;

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  bool _loginPasswordVisible = false;

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 28),

              // App name header
              const Text(
                'VORMIREX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 28),

              // Logo
              Image.asset(
                'assets/new_logo.png',
                height: screenHeight * 0.09,
                width: screenWidth * 0.2,
              ),

              const SizedBox(height: 22),

              // Heading + subtitle
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isLogin
                    ? _PageHeader(
                        key: const ValueKey('login_h'),
                        title: 'Welcome back 👋',
                        subtitle:
                            'Sign in to continue your AI-powered\nlearning journey.',
                      )
                    : _PageHeader(
                        key: const ValueKey('signup_h'),
                        title: 'Create Account ✨',
                        subtitle:
                            'Join and start your AI-powered\nlearning journey.',
                      ),
              ),

              const SizedBox(height: 28),

              // Form card
              Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AnimatedSwitcher(
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
                            () =>
                                _loginPasswordVisible = !_loginPasswordVisible,
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
                            () => _signupPasswordVisible =
                                !_signupPasswordVisible,
                          ),
                          onToggleConfirmPassword: () => setState(
                            () => _signupConfirmPasswordVisible =
                                !_signupConfirmPasswordVisible,
                          ),
                          authController: _authController,
                          onSignupSuccess: () =>
                              setState(() => _isLogin = true),
                        ),
                ),
              ),

              const SizedBox(height: 26),

              // OR divider
              const _OrDivider(),

              const SizedBox(height: 20),

              // Continue with Google
              _SocialButton(label: 'Continue with Google', icon: _GoogleIcon()),

              const SizedBox(height: 14),

              // Continue with Apple
              _SocialButton(
                label: 'Continue with Apple',
                icon: const Icon(Icons.apple, color: Colors.white, size: 22),
              ),

              const SizedBox(height: 28),

              // Toggle sign in / sign up
              GestureDetector(
                onTap: () => setState(() => _isLogin = !_isLogin),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14),
                    children: [
                      TextSpan(
                        text: _isLogin
                            ? "Don't have an account? "
                            : 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      TextSpan(
                        text: _isLogin ? 'Sign up' : 'Sign in',
                        style: const TextStyle(
                          color: AppColors.accentCyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Page Header ──────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PageHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
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
          hint: '••••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: !passwordVisible,
          suffixIcon: passwordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: onTogglePassword,
        ),

        const SizedBox(height: 12),

        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Get.to(() => ForgotPasswordScreen()),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: AppColors.accentCyan,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Obx(
          () => _GradientButton(
            label: 'Sign In',
            isLoading: authController.isLoading.value,
            onTap: () => authController.login(
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        ),
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
          hint: '••••••••',
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
          hint: '••••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: !confirmPasswordVisible,
          suffixIcon: confirmPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: onToggleConfirmPassword,
        ),

        const SizedBox(height: 28),

        Obx(
          () => _GradientButton(
            label: 'Create Account',
            isLoading: authController.isLoading.value,
            onTap: () async {
              await authController.signup(
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
              );
              if (!authController.isLoading.value) {
                onSignupSuccess();
              }
            },
          ),
        ),
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
        color: Colors.white.withValues(alpha: 0.7),
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
        border: Border.all(color: const Color(0xFF363636), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
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

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const _GradientButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [
                    Color(0xFF3CD9C3).withValues(alpha: 0.6),
                    Color(0xFF2BBFA9).withValues(alpha: 0.6),
                  ]
                : const [Color(0xFF3CD9C3), Color(0xFF2BBFA9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF363636), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF363636), thickness: 1)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;

  const _SocialButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.cardBg,
          side: const BorderSide(color: Color(0xFF363636), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
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
      Paint()..color = AppColors.cardBg,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
