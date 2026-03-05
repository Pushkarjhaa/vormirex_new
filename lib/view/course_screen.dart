import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/course_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/course_detail_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late final CourseController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.isRegistered<CourseController>()
        ? Get.find<CourseController>()
        : Get.put(CourseController());
  }

  @override
  Widget build(BuildContext context) {
    // ONE GetBuilder wraps the entire screen so chips + list always rebuild together
    return GetBuilder<CourseController>(
      builder: (c) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ──
                  const Text(
                    'Explore Courses',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Discover your next skill',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // ── Search bar ──
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.accentCyan.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 14),
                              const Icon(
                                Icons.search,
                                color: Colors.white38,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  onChanged: c.onSearchChanged,
                                  decoration: const InputDecoration(
                                    hintText: 'Search Courses...',
                                    hintStyle: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                            color: AppColors.accentCyan.withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.white54,
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ── Category chips ──
                  SizedBox(
                    height: 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: c.categoryLabels.length,
                      itemBuilder: (_, i) {
                        final isActive = c.selectedIndex == i;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => c.onCategoryChanged(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.accentCyan
                                    : AppColors.cardBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                c.chipLabel(i),
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
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),

            // ── Course list ──
            Expanded(child: _buildList(c)),
          ],
        ),
      ),
    );
  }

  Widget _buildList(CourseController c) {
    if (c.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.accentCyan,
          strokeWidth: 2.5,
        ),
      );
    }

    if (c.errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_outlined,
                color: Colors.white24,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                c.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: c.fetchCourses,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (c.filteredCourses.isEmpty) {
      return const Center(
        child: Text(
          'No courses found.',
          style: TextStyle(color: Colors.white38, fontSize: 14),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: c.filteredCourses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final course = c.filteredCourses[i];
        return GestureDetector(
          onTap: () =>
              Get.to(() => const CourseDetailScreen(), arguments: course),
          child: _CourseCard(course: course),
        );
      },
    );
  }
}

// ─── Course Card ──────────────────────────────────────────────────────────────

class _CourseCard extends StatelessWidget {
  final Course course;
  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                course.thumbnail,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: const Color(0xFF0D3330),
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.white24,
                      size: 40,
                    ),
                  ),
                ),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 160,
                    color: const Color(0xFF0D3330),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentCyan,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accentCyan.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    course.level,
                    style: TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    course.formattedPrice,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  course.subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _Chip(Icons.schedule_outlined, course.totalDuration),
                    const SizedBox(width: 10),
                    _Chip(
                      Icons.menu_book_outlined,
                      '${course.totalModules} Modules',
                    ),
                    const SizedBox(width: 10),
                    _Chip(
                      Icons.layers_outlined,
                      '${course.levels.length} Levels',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: course.tags
                      .take(3)
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.accentCyan.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: AppColors.accentCyan.withOpacity(0.8),
                              fontSize: 11,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white38, size: 13),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
      ],
    );
  }
}
