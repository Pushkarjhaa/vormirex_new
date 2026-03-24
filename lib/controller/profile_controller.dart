import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/utils/url.dart';

class ProfileController extends GetxController {
  // ── Observable state ──────────────────────────────────────────────────────
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString profilePhotoUrl = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ── Fetch profile ─────────────────────────────────────────────────────────
  Future<void> fetchProfile() async {
    isLoading.value = true;

    try {
      final authController = Get.find<AuthController>();
      final token = authController.token.value;

      if (token.isEmpty) {
        _showError('Not authenticated. Please log in again.');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiUrls.getProfile),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final user = data['user'];
        name.value = user['name'] ?? '';
        email.value = user['email'] ?? '';
        phoneNumber.value = user['phoneNumber'] ?? '';
        profilePhotoUrl.value = user['profilePhoto'] ?? '';

        // Keep AuthController in sync
        authController.userName.value = name.value;
        authController.userEmail.value = email.value;
      } else {
        _showError(data['message'] ?? 'Failed to load profile.');
      }
    } catch (e) {
      _showError('Network error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Update profile (name + phone only) ───────────────────────────────────
  Future<void> updateProfile({
    required String newName,
    required String newPhone,
    void Function(String)? onSuccess,
    void Function(String)? onError,
  }) async {
    isSaving.value = true;

    try {
      final authController = Get.find<AuthController>();
      final token = authController.token.value;

      final response = await http.patch(
        Uri.parse(ApiUrls.updateProfile),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': newName, 'phoneNumber': newPhone}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        name.value = newName;
        phoneNumber.value = newPhone;

        // Keep AuthController name in sync (email is not editable)
        authController.userName.value = newName;

        onSuccess?.call(data['message'] ?? 'Profile updated successfully.');
      } else {
        onError?.call(data['message'] ?? 'Failed to update profile.');
      }
    } catch (e) {
      onError?.call('Network error: ${e.toString()}');
    } finally {
      isSaving.value = false;
    }
  }

  // ── Upload profile photo ──────────────────────────────────────────────────
  Future<void> uploadProfilePhoto({
    required File imageFile,
    void Function(String)? onSuccess,
    void Function(String)? onError,
  }) async {
    isSaving.value = true;

    try {
      final authController = Get.find<AuthController>();
      final token = authController.token.value;

      final request =
          http.MultipartRequest('POST', Uri.parse(ApiUrls.updateProfilePhoto))
            ..headers['Authorization'] = 'Bearer $token'
            ..files.add(
              await http.MultipartFile.fromPath(
                'photo', // field name the API expects
                imageFile.path,
                contentType: MediaType('image', 'jpeg'),
              ),
            );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['profilePhoto'] != null) {
        profilePhotoUrl.value = data['profilePhoto'];
        onSuccess?.call(data['message'] ?? 'Profile photo updated.');
      } else {
        onError?.call(data['message'] ?? 'Failed to update photo.');
      }
    } catch (e) {
      onError?.call('Network error: ${e.toString()}');
    } finally {
      isSaving.value = false;
    }
  }

  // ── Helper ────────────────────────────────────────────────────────────────
  void _showError(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
