import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/controller/course_controller.dart';

// ─── Palette ──────────────────────────────────────────────────────────────────
const _card   = Color(0xFF111A28);
const _border = Color(0xFF1E2A38);
const _teal   = Color(0xFF3CD9C3);
const _textPri = Colors.white;
const _textSec = Color(0xFF7A7A9A);

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late final CourseController _c;
  int _filterIdx = 0;
  final _filters = ['All', 'Physics', 'Mathematics', 'Chemistry', 'CS'];

  @override
  void initState() {
    super.initState();
    _c = Get.isRegistered<CourseController>()
        ? Get.find<CourseController>()
        : Get.put(CourseController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Header ───────────────────────────────────────────────────
            _buildHeader(),

            const SizedBox(height: 16),

            // ── Search bar ───────────────────────────────────────────────
            _SearchBar(),

            const SizedBox(height: 14),

            // ── Filter chips ─────────────────────────────────────────────
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) => _FilterChip(
                  label: _filters[i],
                  isActive: _filterIdx == i,
                  onTap: () => setState(() => _filterIdx = i),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Currently Learning ───────────────────────────────────────
            const _CurrentlyLearningCard(),

            const SizedBox(height: 22),

            // ── Active Courses ───────────────────────────────────────────
            _sectionRow('Active Courses', trailing: 'View all'),
            const SizedBox(height: 12),
            const _ActiveCourseItem(
              icon: Icons.waves_outlined,
              title: 'Quantum Mechanics',
              subtitle: 'Lesson 4 of 12',
              progress: 0.33,
            ),
            const SizedBox(height: 10),
            const _ActiveCourseItem(
              icon: Icons.functions_outlined,
              title: 'Advanced Algebra',
              subtitle: 'Lesson 8 of 15',
              progress: 0.53,
            ),

            const SizedBox(height: 22),

            // ── All Courses grid ─────────────────────────────────────────
            _sectionRow('All Courses'),
            const SizedBox(height: 12),
            const _AllCoursesGrid(),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.menu, color: _textPri, size: 22),
        const SizedBox(width: 10),
        const Text(
          'Explore',
          style: TextStyle(
              color: _textPri, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        // "Your Courses" pill button
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _teal.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: _teal.withValues(alpha: 0.5), width: 1),
          ),
          child: const Text(
            'Your Courses',
            style: TextStyle(
                color: _teal, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _card,
            border: Border.all(color: _teal, width: 1.5),
          ),
          child: const Icon(Icons.person, color: _teal, size: 18),
        ),
      ],
    );
  }

  Widget _sectionRow(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: _textPri,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        if (trailing != null)
          Text(trailing,
              style: const TextStyle(
                  color: _teal, fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ─── Search Bar ───────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border, width: 1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search, color: _textSec, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: const TextStyle(color: _textPri, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search courses, topics...',
                hintStyle: TextStyle(color: _textSec, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Chip ──────────────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterChip(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? _teal : _card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isActive ? _teal : _border, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : _textSec,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─── Currently Learning Card ──────────────────────────────────────────────────
class _CurrentlyLearningCard extends StatelessWidget {
  const _CurrentlyLearningCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D2A2A), Color(0xFF081818)],
        ),
        border: Border.all(color: _teal.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "CURRENTLY LEARNING" label
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: _teal, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              const Text(
                'CURRENTLY LEARNING',
                style: TextStyle(
                  color: _teal,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course info
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Introduction to\nQuantum Theory',
                      style: TextStyle(
                        color: _textPri,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'By Dr. Julian Thorne',
                      style: TextStyle(color: _textSec, fontSize: 12),
                    ),
                  ],
                ),
              ),

              // Circular progress
              SizedBox(
                width: 64,
                height: 64,
                child: CustomPaint(
                  painter: _MiniArcPainter(progress: 0.75),
                  child: const Center(
                    child: Text(
                      '75%',
                      style: TextStyle(
                        color: _teal,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Continue button
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              color: _teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniArcPainter extends CustomPainter {
  final double progress;
  const _MiniArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - 5;
    canvas.drawCircle(
      c, r,
      Paint()
        ..color = _teal.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = _teal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _MiniArcPainter old) =>
      old.progress != progress;
}

// ─── Active Course Item ───────────────────────────────────────────────────────
class _ActiveCourseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double progress;

  const _ActiveCourseItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Icon box
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _teal.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _teal.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Icon(icon, color: _teal, size: 20),
                ),
                const SizedBox(width: 12),
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: _textPri,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                              color: _textSec, fontSize: 12)),
                    ],
                  ),
                ),
                // Play button
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: _teal.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: _teal.withValues(alpha: 0.4), width: 1),
                  ),
                  child: const Icon(Icons.play_arrow_rounded,
                      color: _teal, size: 18),
                ),
              ],
            ),
          ),
          // Progress bar at bottom
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 3,
              backgroundColor: _teal.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation<Color>(_teal),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── All Courses Grid ─────────────────────────────────────────────────────────
class _AllCoursesGrid extends StatelessWidget {
  const _AllCoursesGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.78,
      children: const [
        _CourseCard(
          title: 'Organic Chemistry',
          lessons: '24 Lessons',
          badge: 'HARD',
          badgeColor: Colors.redAccent,
          bgColor: Color(0xFF1A1020),
          enrolled: false,
        ),
        _CourseCard(
          title: 'Swift Programming',
          lessons: '18 Lessons',
          badge: 'INTERM.',
          badgeColor: _teal,
          bgColor: Color(0xFF0A1A28),
          enrolled: true,
        ),
        _CourseCard(
          title: 'Web Design',
          lessons: '12 Lessons',
          badge: 'BEGINNER',
          badgeColor: Color(0xFF9B6DD6),
          bgColor: Color(0xFF1A1028),
          enrolled: false,
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;
  final String lessons;
  final String badge;
  final Color badgeColor;
  final Color bgColor;
  final bool enrolled;

  const _CourseCard({
    required this.title,
    required this.lessons,
    required this.badge,
    required this.badgeColor,
    required this.bgColor,
    required this.enrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(color: bgColor),
                child: Center(
                  child: Icon(
                    _iconForBadge(badge),
                    color: badgeColor.withValues(alpha: 0.6),
                    size: 44,
                  ),
                ),
              ),
              // Difficulty badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: badgeColor.withValues(alpha: 0.5), width: 1),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      color: badgeColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: _textPri,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(lessons,
                    style:
                        const TextStyle(color: _textSec, fontSize: 11)),
                const SizedBox(height: 10),
                // Enroll / Continue button
                Container(
                  width: double.infinity,
                  height: 32,
                  decoration: BoxDecoration(
                    color: enrolled ? _teal : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: enrolled
                        ? null
                        : Border.all(color: _teal, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      enrolled ? 'Continue' : 'Enroll',
                      style: TextStyle(
                        color: enrolled ? Colors.black : _teal,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForBadge(String badge) {
    if (badge == 'HARD') return Icons.science_outlined;
    if (badge == 'INTERM.') return Icons.code_outlined;
    return Icons.brush_outlined;
  }
}
