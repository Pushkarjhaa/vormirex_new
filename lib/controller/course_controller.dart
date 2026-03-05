import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vormirex_new/utils/url.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class CourseModule {
  final String title;
  final List<String> items;
  CourseModule({required this.title, required this.items});
  factory CourseModule.fromJson(Map<String, dynamic> j) => CourseModule(
    title: j['title'] ?? '',
    items: List<String>.from(j['items'] ?? []),
  );
}

class CourseLevel {
  final String level;
  final String duration;
  final List<String> highlights;
  final List<CourseModule> modules;
  CourseLevel({
    required this.level,
    required this.duration,
    required this.highlights,
    required this.modules,
  });
  factory CourseLevel.fromJson(Map<String, dynamic> j) => CourseLevel(
    level: j['level'] ?? '',
    duration: j['duration'] ?? '',
    highlights: List<String>.from(j['highlights'] ?? []),
    modules: (j['modules'] as List? ?? [])
        .map((m) => CourseModule.fromJson(m))
        .toList(),
  );
}

class Course {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final double price;
  final String thumbnail;
  final String level;
  final List<CourseLevel> levels;
  final List<String> tags;

  Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.level,
    required this.levels,
    required this.tags,
  });

  factory Course.fromJson(Map<String, dynamic> j) => Course(
    id: j['id'] ?? j['_id'] ?? '',
    title: j['title'] ?? '',
    subtitle: j['subtitle'] ?? '',
    description: j['description'] ?? '',
    price: (j['price'] ?? 0).toDouble(),
    thumbnail: j['thumbnail'] ?? '',
    level: j['level'] ?? '',
    levels: (j['levels'] as List? ?? [])
        .map((l) => CourseLevel.fromJson(l))
        .toList(),
    tags: List<String>.from(j['tags'] ?? []),
  );

  String get totalDuration {
    int months = levels.fold(
      0,
      (s, l) => s + (int.tryParse(l.duration.split(' ').first) ?? 0),
    );
    return '$months Months';
  }

  int get totalModules => levels.fold(0, (s, l) => s + l.modules.length);

  String get formattedPrice => '₹${price.toInt()}';
}

// ─── Controller ───────────────────────────────────────────────────────────────

class CourseController extends GetxController {
  // Plain lists — NOT .obs — GetBuilder manages rebuilds via update()
  List<Course> courses = [];
  List<Course> filteredCourses = [];
  bool isLoading = false;
  String errorMessage = '';
  int selectedIndex = 0;
  String searchQuery = '';

  final List<String> categoryTags = [
    'all',
    'data-analytics',
    'ai',
    'cyber-security',
    'data-science',
  ];

  final List<String> categoryLabels = [
    'All',
    'Data Analysis',
    'AI / ML',
    'Cyber',
    'Data Science',
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCourses();
    });
  }

  Future<void> fetchCourses() async {
    isLoading = true;
    errorMessage = '';
    update(); // ← tell GetBuilder to rebuild (show spinner)

    try {
      final response = await http
          .get(Uri.parse(ApiUrls.courses))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        courses = (body['courses'] as List? ?? [])
            .map((c) => Course.fromJson(c as Map<String, dynamic>))
            .toList();
        _filter();
      } else {
        errorMessage = 'Error ${response.statusCode}. Tap retry.';
      }
    } catch (e) {
      errorMessage = 'Network error. Tap retry.';
      debugPrint('fetchCourses error: $e');
    } finally {
      isLoading = false;
      update(); // ← tell GetBuilder to rebuild (show results/error)
    }
  }

  void onCategoryChanged(int index) {
    selectedIndex = index;
    _filter();
    update(); // ← tell GetBuilder to rebuild (update chips + list)
  }

  void onSearchChanged(String q) {
    searchQuery = q.toLowerCase().trim();
    _filter();
    update(); // ← tell GetBuilder to rebuild (update list)
  }

  void _filter() {
    var result = List<Course>.from(courses);

    if (selectedIndex != 0) {
      final tag = categoryTags[selectedIndex];
      result = result.where((c) => c.tags.contains(tag)).toList();
    }

    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (c) =>
                c.title.toLowerCase().contains(searchQuery) ||
                c.tags.any((t) => t.contains(searchQuery)),
          )
          .toList();
    }

    filteredCourses = result;
    // No update() here — callers handle it
  }

  String chipLabel(int i) {
    if (i == 0) return 'All ${courses.length}';
    final tag = categoryTags[i];
    final count = courses.where((c) => c.tags.contains(tag)).length;
    return '${categoryLabels[i]} $count';
  }
}
