import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Progress',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('Track your learning journey',
                style: TextStyle(color: Colors.white54, fontSize: 14)),

            const SizedBox(height: 20),

            // Stats row
            Row(children: [
              Expanded(
                child: AppCard(
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xFF0D3330),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.access_time,
                          color: AppColors.accentCyan, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('9.0h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                          Text('This week',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12)),
                        ]),
                  ]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppCard(
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xFF0D3330),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.trending_up,
                          color: AppColors.accentCyan, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('85%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                          Text('Accuracy',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12)),
                        ]),
                  ]),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            // Weekly Activity
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.trending_up,
                        color: AppColors.accentCyan, size: 18),
                    const SizedBox(width: 8),
                    const Text('Weekly Activity',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ]),
                  const SizedBox(height: 16),
                  const WeeklyBarChart(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Strengths & Needs Work
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.check_circle_outline,
                              color: Colors.green, size: 16),
                          const SizedBox(width: 6),
                          const Text('Strengths',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ]),
                        const SizedBox(height: 12),
                        SkillBar('Python Basics', 0.92, '92%', Colors.green),
                        const SizedBox(height: 8),
                        SkillBar('Data Structures', 0.88, '88%', Colors.green),
                        const SizedBox(height: 8),
                        SkillBar('Algorithms', 0.85, '85%', Colors.green),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.access_time_outlined,
                              color: Colors.orange, size: 16),
                          const SizedBox(width: 6),
                          const Text('Needs Work',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ]),
                        const SizedBox(height: 12),
                        SkillBar('Recursion', 0.45, '45%', Colors.orange),
                        const SizedBox(height: 8),
                        SkillBar('Dynamic Prog.', 0.48, '48%', Colors.orange),
                        const SizedBox(height: 8),
                        SkillBar('Graph Algo.', 0.58, '58%', Colors.orange),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Achievements
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.emoji_events_outlined,
                        color: AppColors.accentCyan, size: 20),
                    const SizedBox(width: 8),
                    const Text('Achievements',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ]),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                    children: const [
                      AchievementBadge(label: '7 Day Streak'),
                      AchievementBadge(label: 'First Course'),
                      AchievementBadge(label: '1000 XP'),
                      AchievementBadge(label: 'Quiz Master'),
                      AchievementBadge(label: '10 Courses'),
                      AchievementBadge(label: 'Perfect Week'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [0.7, 0.9, 0.2, 0.85, 0.75, 0.6, 0.15];

    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(days.length, (i) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      heightFactor: values[i],
                      child: Container(
                        decoration: BoxDecoration(
                          color: values[i] > 0.4
                              ? AppColors.accentCyan
                              : Colors.white12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(days[i],
                      style:
                          const TextStyle(color: Colors.white38, fontSize: 10)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SkillBar extends StatelessWidget {
  final String label;
  final double value;
  final String percent;
  final Color color;

  const SkillBar(this.label, this.value, this.percent, this.color,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(label,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11),
                  overflow: TextOverflow.ellipsis),
            ),
            Text(percent,
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

class AchievementBadge extends StatelessWidget {
  final String label;
  const AchievementBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D3330),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_fire_department,
              color: AppColors.accentCyan, size: 20),
          const SizedBox(height: 4),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}