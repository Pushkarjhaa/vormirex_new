import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/course_detail_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/my_cart_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseDetailController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCourseDetail(courseId);
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────────────
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.cardBg,
                  border: Border(bottom: BorderSide(color: Colors.white10)),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Course Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.toggleWishlist,
                      child: Icon(
                        controller.isWishlisted.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isWishlisted.value
                            ? Colors.red
                            : Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),

            // ── Body ─────────────────────────────────────────────────────
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentCyan,
                    ),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.errorMessage.value,
                          style: const TextStyle(color: Colors.white54),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              controller.fetchCourseDetail(courseId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentCyan,
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.course.isEmpty) {
                  return const SizedBox.shrink();
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      Center(
                        child: Container(
                          width: 360,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: controller.thumbnail.isNotEmpty
                              ? Image.network(
                                  controller.thumbnail,
                                  fit: BoxFit.fill,
                                  errorBuilder: (_, __, ___) => const Center(
                                    child: Icon(
                                      Icons.book,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.book,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Title
                      Center(
                        child: Text(
                          controller.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Subtitle
                      Center(
                        child: Text(
                          controller.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Level tabs
                      if (controller.levels.isNotEmpty)
                        _LevelTabs(controller: controller),

                      const SizedBox(height: 16),

                      // Highlights
                      if (controller.selectedHighlights.isNotEmpty)
                        _HighlightsRow(
                          highlights: controller.selectedHighlights,
                        ),

                      const SizedBox(height: 16),

                      // About
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About this course',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.description,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 13,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Duration chip
                      if (controller.selectedLevel != null)
                        _InfoRow(
                          duration:
                              controller.selectedLevel!['duration']
                                  ?.toString() ??
                              '',
                          level:
                              controller.selectedLevel!['level']?.toString() ??
                              '',
                        ),

                      const SizedBox(height: 12),

                      // Modules
                      if (controller.selectedModules.isNotEmpty) ...[
                        const Text(
                          "Course Modules",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...controller.selectedModules.map((module) {
                          final moduleId = module['_id']?.toString() ?? '';
                          final moduleTitle = module['title']?.toString() ?? '';
                          final items = List<String>.from(
                            module['items'] ?? [],
                          );
                          return _ModuleTile(
                            moduleId: moduleId,
                            title: moduleTitle,
                            items: items,
                            controller: controller,
                          );
                        }),
                      ],

                      const SizedBox(height: 24),

                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.formattedPrice,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentCyan.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.accentCyan,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              controller.level,
                              style: TextStyle(
                                color: AppColors.accentCyan,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Add to Cart
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => const MyCartScreen()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentCyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Add Course to Cart',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Level Tabs ────────────────────────────────────────────────────────────────

class _LevelTabs extends StatelessWidget {
  final CourseDetailController controller;
  const _LevelTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(controller.levels.length, (i) {
          final lvl = controller.levels[i];
          final isSelected = controller.selectedLevelIndex.value == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectLevel(i),
              child: Container(
                margin: EdgeInsets.only(
                  right: i < controller.levels.length - 1 ? 8 : 0,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accentCyan : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.accentCyan : Colors.white12,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      lvl['level']?.toString() ?? '',
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      lvl['duration']?.toString() ?? '',
                      style: TextStyle(
                        color: isSelected ? Colors.black54 : Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Highlights Row ────────────────────────────────────────────────────────────

class _HighlightsRow extends StatelessWidget {
  final List<String> highlights;
  const _HighlightsRow({required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: highlights
          .map(
            (h) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accentCyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.accentCyan.withOpacity(0.4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.accentCyan,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    h,
                    style: TextStyle(color: AppColors.accentCyan, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ── Info Row ──────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String duration;
  final String level;
  const _InfoRow({required this.duration, required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _chip(Icons.access_time, duration),
        const SizedBox(width: 10),
        _chip(Icons.signal_cellular_alt, level),
      ],
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.accentCyan, size: 15),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ── Module Tile ───────────────────────────────────────────────────────────────

class _ModuleTile extends StatelessWidget {
  final String moduleId;
  final String title;
  final List<String> items;
  final CourseDetailController controller;

  const _ModuleTile({
    required this.moduleId,
    required this.title,
    required this.items,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isExpanded = controller.expandedModules.contains(moduleId);
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isExpanded
                ? AppColors.accentCyan.withOpacity(0.3)
                : Colors.white10,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => controller.toggleModule(moduleId),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white38,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
                child: Column(
                  children: items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: AppColors.accentCyan,
                                size: 6,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      );
    });
  }
}
