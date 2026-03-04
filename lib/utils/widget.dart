import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  const AppCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class CyanProgressBar extends StatelessWidget {
  final double value;
  const CyanProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.white12,
        valueColor: const AlwaysStoppedAnimation(AppColors.accentCyan),
        minHeight: 8,
      ),
    );
  }
}

class CourseData {
  final String title;
  final String level;
  final String duration;
  final String lessons;
  final double rating;
  final String imagePath; // asset image path

  const CourseData(
    this.title,
    this.level,
    this.duration,
    this.lessons,
    this.rating, {
    this.imagePath = 'assets/logo_python.png', // default fallback
  });
}

class CourseCard extends StatelessWidget {
  final CourseData course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          // Course thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              course.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text('🐍', style: TextStyle(fontSize: 28)),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    LevelBadge(course.level),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.access_time,
                      color: Colors.white38,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      course.duration,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.menu_book_outlined,
                      color: Colors.white38,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      course.lessons,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      course.rating.toString(),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.people_outline,
                      color: Colors.white38,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      '45.2k',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LevelBadge extends StatelessWidget {
  final String level;
  const LevelBadge(this.level, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level,
        style: const TextStyle(color: Colors.white70, fontSize: 11),
      ),
    );
  }
}

class CyanSwitch extends StatefulWidget {
  final bool value;
  const CyanSwitch({super.key, required this.value});

  @override
  State<CyanSwitch> createState() => _CyanSwitchState();
}

class _CyanSwitchState extends State<CyanSwitch> {
  late bool _val;

  @override
  void initState() {
    super.initState();
    _val = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _val,
      onChanged: (v) => setState(() => _val = v),
      activeColor: AppColors.accentCyan,
      activeTrackColor: AppColors.accentCyan.withOpacity(0.3),
      inactiveThumbColor: Colors.white38,
      inactiveTrackColor: Colors.white12,
    );
  }
}
