import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vormirex_new/utils/url.dart';

class CourseDetailController extends GetxController {
  final RxMap<String, dynamic> course = <String, dynamic>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isWishlisted = false.obs;
  final RxInt selectedLevelIndex = 0.obs;
  final RxSet<String> expandedModules = <String>{}.obs;

  void toggleWishlist() => isWishlisted.toggle();

  void toggleModule(String moduleId) {
    if (expandedModules.contains(moduleId)) {
      expandedModules.remove(moduleId);
    } else {
      expandedModules.add(moduleId);
    }
  }

  void selectLevel(int index) => selectedLevelIndex.value = index;

  Future<void> fetchCourseDetail(String courseId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse(ApiUrls.courseDetail(courseId)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          course.value = json['data'];
        } else {
          errorMessage.value = 'Failed to load course details.';
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String get title => course['title'] ?? '';
  String get subtitle => course['subtitle'] ?? '';
  String get description => course['description'] ?? '';
  String get thumbnail => course['thumbnail'] ?? '';
  String get level => course['level'] ?? '';
  int get price => course['price'] ?? 0;

  String get formattedPrice {
    final p = price / 100;
    return '₹${p.toStringAsFixed(0)}';
  }

  List<dynamic> get levels => course['levels'] ?? [];

  Map<String, dynamic>? get selectedLevel {
    if (levels.isEmpty) return null;
    if (selectedLevelIndex.value >= levels.length) return null;
    return levels[selectedLevelIndex.value];
  }

  List<dynamic> get selectedModules =>
      (selectedLevel?['modules'] as List<dynamic>?) ?? [];

  List<String> get selectedHighlights =>
      List<String>.from(selectedLevel?['highlights'] ?? []);
}
