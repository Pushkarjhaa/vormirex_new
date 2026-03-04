import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/course_detail_screen.dart';


class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int _selectedCategory = 0;
  final _categories = [
    'All 20',
    'Data Science 5',
    'AI/ML 5',
    'Cyber 3',
    'Web 7',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Explore Courses',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  'Discover your next skill',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 16),

                // Search + Filter
                Row(children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.accentCyan.withOpacity(0.3)),
                      ),
                      child: Row(children: [
                        const SizedBox(width: 14),
                        const Icon(Icons.search,
                            color: Colors.white38, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Search Courses...',
                              hintStyle: TextStyle(
                                  color: Colors.white30, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.accentCyan.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.filter_list,
                        color: Colors.white54, size: 22),
                  ),
                ]),

                const SizedBox(height: 14),

                // Category chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final isActive = i == _selectedCategory;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.accentCyan
                                : AppColors.cardBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _categories[i],
                            style: TextStyle(
                              color: isActive
                                  ? Colors.black
                                  : Colors.white54,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Course list — tap each card to go to CourseDetailScreen
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, __) => GestureDetector(
                onTap: () => Get.to(() => const CourseDetailScreen()),
                child: CourseCard(
                  course: const CourseData(
                    'Complete Python Masterclass',
                    'Beginner',
                    '24H',
                    '48 lessons',
                    4.9,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}