import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vormirex_new/utils/main_screen.dart';
import 'package:vormirex_new/utils/url.dart';
import 'package:vormirex_new/view/auth/auth_screen.dart';

class AuthController extends GetxController {
  // ─── Observables ────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;

  // ── Logged-in user info (reactive) ──
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userId = ''.obs;
  final RxString userRole = ''.obs;

  // ─── SharedPreferences Keys ──────────────────────────────────────────────────
  static const String _tokenKey = 'access_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userRoleKey = 'user_role';

  // ─── On Init: load saved user data ──────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString(_userNameKey) ?? '';
    userEmail.value = prefs.getString(_userEmailKey) ?? '';
    userId.value = prefs.getString(_userIdKey) ?? '';
    userRole.value = prefs.getString(_userRoleKey) ?? '';
  }

  // ─── Login ───────────────────────────────────────────────────────────────────
  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _showSnackbar('Error', 'Please fill in all fields.', isError: true);
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim(), 'password': password}),
      );

      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200 && data['success'] == true) {
        // ── Save to SharedPreferences ──
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, data['accessToken'] ?? '');
        await prefs.setString(_userIdKey, data['user']['id'] ?? '');
        await prefs.setString(_userNameKey, data['user']['name'] ?? '');
        await prefs.setString(_userEmailKey, data['user']['email'] ?? '');
        await prefs.setString(_userRoleKey, data['user']['role'] ?? '');

        // ── Update reactive observables immediately ──
        userName.value = data['user']['name'] ?? '';
        userEmail.value = data['user']['email'] ?? '';
        userId.value = data['user']['id'] ?? '';
        userRole.value = data['user']['role'] ?? '';

        _showSnackbar('Welcome back!', 'Logged in successfully.');
        Get.offAll(() => const MainScreen());
      } else {
        final message = data['message'] ?? 'Login failed. Please try again.';
        _showSnackbar('Login Failed', message, isError: true);
      }
    } catch (e) {
      _showSnackbar(
        'Network Error',
        'Unable to connect. Please check your internet connection.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Sign Up ─────────────────────────────────────────────────────────────────
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackbar('Error', 'Please fill in all fields.', isError: true);
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar('Error', 'Passwords do not match.', isError: true);
      return;
    }

    if (password.length < 6) {
      _showSnackbar(
        'Error',
        'Password must be at least 6 characters.',
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.signup),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name.trim(),
          'email': email.trim(),
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _showSnackbar(
          'Account Created!',
          data['message'] ?? 'Please verify your email to continue.',
        );
      } else {
        final message = data['message'] ?? 'Signup failed. Please try again.';
        _showSnackbar('Signup Failed', message, isError: true);
      }
    } catch (e) {
      _showSnackbar(
        'Network Error',
        'Unable to connect. Please check your internet connection.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Logout ──────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userRoleKey);

    // Clear observables
    userName.value = '';
    userEmail.value = '';
    userId.value = '';
    userRole.value = '';

    Get.offAll(() => const AuthScreen());

    // ✅ Show snackbar after navigation so it renders on AuthScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.snackbar(
        'Logged Out',
        'You have been logged out successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF1A4A42),
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      );
    });
  }

  // ─── Token Helpers ───────────────────────────────────────────────────────────
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ─── Snackbar Helper ─────────────────────────────────────────────────────────
  void _showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError
          ? Colors.red.withOpacity(0.85)
          : const Color(0xFF1A4A42),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
      ),
    );
  }
}
