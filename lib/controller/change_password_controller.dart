import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vormirex_new/controller/auth_controller.dart';
import 'package:vormirex_new/utils/url.dart';

class ChangePasswordController extends GetxController {
  // ✅ Only loading state here — NO TextEditingControllers in GetX controller
  final RxBool isLoading = false.obs;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    final AuthController authController = Get.find<AuthController>();
    final token = await authController.getToken();

    print('🔑 Token: $token');

    if (token == null || token.isEmpty) {
      onError('Session expired. Please log in again.');
      return;
    }

    isLoading.value = true;

    final client = http.Client();
    try {
      final uri = Uri.parse(ApiUrls.changePassword);
      final request = http.Request('PATCH', uri);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      request.body = jsonEncode({
        'currentPassword': oldPassword,
        'newPassword': newPassword,
      });

      print('📡 PATCH $uri');
      print('📦 Body: ${request.body}');

      final streamedResponse = await client
          .send(request)
          .timeout(const Duration(seconds: 30));
      final response = await http.Response.fromStream(streamedResponse);

      print('📥 Status: ${response.statusCode}');
      print('📥 Body: ${response.body}');

      Map<String, dynamic> data = {};
      if (response.body.isNotEmpty) {
        try {
          data = jsonDecode(response.body);
        } catch (_) {}
      }

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 204) {
        final message = data['message'] ?? 'Password changed successfully.';
        onSuccess(message);
      } else if (response.statusCode == 401) {
        onError('Session expired. Please log in again.');
        await Future.delayed(const Duration(seconds: 2));
        authController.logout();
      } else {
        final errorMsg =
            data['message'] ??
            data['error'] ??
            data['msg'] ??
            'Something went wrong. (${response.statusCode})';
        onError(errorMsg.toString());
      }
    } on TimeoutException {
      isLoading.value = false;
      onError('Request timed out. Please try again.');
    } on Exception catch (e) {
      isLoading.value = false;
      print('❌ Exception: $e');
      onError('Network error. Please check your connection.');
    } finally {
      client.close();
    }
  }
}
