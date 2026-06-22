import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/ai_tutor_screen.dart';
import 'package:vormirex_new/view/course_screen.dart';
import 'package:vormirex_new/view/profile_screen.dart';
import 'package:vormirex_new/view/progress.screen.dart';

// ─── Palette ──────────────────────────────────────────────────────────────────
const _bg         = AppColors.scaffoldBg;
const _card       = Color(0xFF111A28);
const _cardBorder = Color(0xFF1E2A38);
const _teal       = Color(0xFF3CD9C3);
const _textPri    = Colors.white;
const _textSec    = Color(0xFF7A7A9A);
const _green      = Color(0xFF4ADE80);

// ─── Shell ────────────────────────────────────────────────────────────────────
class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});
  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  int _idx = 0;

  static const _screens = <Widget>[
    _HomeTab(),
    CoursesScreen(),
    AITutorScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: IndexedStack(index: _idx, children: _screens),
      bottomNavigationBar: _BottomNav(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(Icons.home_outlined, Icons.home_rounded, 'Home'),
      _NavItem(Icons.school_outlined, Icons.school_rounded, 'Courses'),
      _NavItem(Icons.smart_toy_outlined, Icons.smart_toy_rounded, 'AI Chat'),
      _NavItem(Icons.show_chart_rounded, Icons.show_chart_rounded, 'Progress'),
      _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111A28),
        border: Border(top: BorderSide(color: Color(0xFF1E2A38), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = i == currentIndex;
              final item = items[i];
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: isActive
                      ? BoxDecoration(
                          color: _teal.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        )
                      : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? item.activeIcon : item.icon,
                        color: isActive ? _teal : _textSec,
                        size: 22,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: isActive ? _teal : _textSec,
                          fontSize: 10,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem(this.icon, this.activeIcon, this.label);
}

// ─── Home Tab ─────────────────────────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ── Header ───────────────────────────────────────────────────
            _Header(),

            const SizedBox(height: 20),

            // ── Streak Card ──────────────────────────────────────────────
            const _StreakCard(),

            const SizedBox(height: 16),

            // ── Stats 2x2 ────────────────────────────────────────────────
            const _StatsGrid(),

            const SizedBox(height: 22),

            // ── Continue Learning ────────────────────────────────────────
            _sectionRow('Continue Learning'),
            const SizedBox(height: 12),
            const _ContinueLearningCard(),

            const SizedBox(height: 22),

            // ── Weekly Activity ──────────────────────────────────────────
            _sectionRow('Weekly Activity'),
            const SizedBox(height: 12),
            const _WeeklyActivityCard(),

            const SizedBox(height: 22),

            // ── Today's Goals ────────────────────────────────────────────
            _sectionRow("Today's Goals", trailing: 'View All'),
            const SizedBox(height: 12),
            const _GoalItem(
              title: 'Morning Quiz',
              xp: '+50 XP Earned',
              status: _GoalStatus.done,
            ),
            const SizedBox(height: 8),
            const _GoalItem(
              title: 'Finish Module 2',
              xp: '+120 XP',
              status: _GoalStatus.active,
            ),
            const SizedBox(height: 8),
            const _GoalItem(
              title: 'Daily Challenge',
              xp: '+200 XP',
              status: _GoalStatus.pending,
            ),

            const SizedBox(height: 22),

            // ── Quick Actions ────────────────────────────────────────────
            _sectionRow('Quick Actions'),
            const SizedBox(height: 12),
            const _QuickActionsGrid(),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _sectionRow(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: _textPri,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        if (trailing != null)
          Text(trailing,
              style: const TextStyle(
                  color: _teal, fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Good Morning 🌤',
                  style: TextStyle(color: _textSec, fontSize: 13)),
              const SizedBox(height: 2),
              const Text('Welcome, Alex!',
                  style: TextStyle(
                      color: _textPri,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4)),
            ],
          ),
        ),
        _iconBtn(Icons.dark_mode_outlined),
        const SizedBox(width: 8),
        _iconBtn(Icons.notifications_outlined),
        const SizedBox(width: 8),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _teal, width: 2),
            color: const Color(0xFF111A28),
          ),
          child: const Icon(Icons.person, color: _teal, size: 20),
        ),
      ],
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: _card,
        shape: BoxShape.circle,
        border: Border.all(color: _cardBorder),
      ),
      child: Icon(icon, color: _textSec, size: 18),
    );
  }
}

// ─── Streak Card ──────────────────────────────────────────────────────────────
class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D3535), Color(0xFF082020)],
        ),
        border: Border.all(color: _teal.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    const Text(
                      '12-Day Streak!',
                      style: TextStyle(
                          color: _textPri,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "Keep it up! You're in the top 5%.",
                  style: TextStyle(
                      color: _textPri.withValues(alpha: 0.55), fontSize: 13),
                ),
              ],
            ),
          ),
          const Text('🔥', style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}

// ─── Stats Grid ───────────────────────────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: const [
        _StatCard(label: 'Study Hours', value: '24.5h', change: '+1%'),
        _StatCard(label: 'XP Earned', value: '1,240', change: '+8%'),
        _StatCard(label: 'Weekly Progress', value: '82%', change: '+5%'),
        _StatCard(label: 'Lessons', value: '18', change: '+3'),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  const _StatCard(
      {required this.label, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style:
                  const TextStyle(color: _textSec, fontSize: 11)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                  style: const TextStyle(
                      color: _textPri,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(change,
                    style: const TextStyle(
                        color: _green,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Continue Learning Card ───────────────────────────────────────────────────
class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Course thumbnail ──────────────────────────────────────────
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.asset(
              'assets/Container.png',
              fit: BoxFit.cover,
            ),
          ),

          // ── Course info ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Python\nFundamentals',
                        style: TextStyle(
                            color: _textPri,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _teal.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _teal.withValues(alpha: 0.3), width: 1),
                      ),
                      child: const Text('45 min\nleft',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _teal,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('Lesson: Functions & Scope',
                    style: TextStyle(color: _textSec, fontSize: 12)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Text('Course Progress',
                        style: TextStyle(color: _textSec, fontSize: 12)),
                    const Spacer(),
                    const Text('65%',
                        style: TextStyle(
                            color: _teal,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 5,
                    backgroundColor: _teal.withValues(alpha: 0.12),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(_teal),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ─── Weekly Activity Card ─────────────────────────────────────────────────────
class _WeeklyActivityCard extends StatelessWidget {
  const _WeeklyActivityCard();

  @override
  Widget build(BuildContext context) {
    const days   = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const values = [0.50, 0.70, 1.00, 0.82, 0.45, 0.28, 0.58];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isTop = values[i] == 1.0;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 90 * values[i],
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: isTop
                              ? [_teal, const Color(0xFF80FFF5)]
                              : [
                                  _teal.withValues(alpha: 0.45),
                                  _teal.withValues(alpha: 0.70),
                                ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: _cardBorder, height: 1),
          const SizedBox(height: 10),
          Row(
            children: List.generate(7, (i) {
              return Expanded(
                child: Text(
                  days[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: values[i] == 1.0 ? _teal : _textSec,
                    fontSize: 11,
                    fontWeight: values[i] == 1.0
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ─── Goal Status ──────────────────────────────────────────────────────────────
enum _GoalStatus { done, active, pending }

// ─── Goal Item ────────────────────────────────────────────────────────────────
class _GoalItem extends StatelessWidget {
  final String title;
  final String xp;
  final _GoalStatus status;
  const _GoalItem(
      {required this.title, required this.xp, required this.status});

  @override
  Widget build(BuildContext context) {
    final bgColor = status == _GoalStatus.done
        ? const Color(0xFF111A28)
        : status == _GoalStatus.active
            ? const Color(0xFF111A28)
            : _card;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: status == _GoalStatus.done
              ? _teal.withValues(alpha: 0.25)
              : _cardBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _StatusDot(status: status),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: status == _GoalStatus.done
                        ? _textSec
                        : _textPri,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: status == _GoalStatus.done
                        ? TextDecoration.lineThrough
                        : null,
                    decorationColor: _textSec,
                  ),
                ),
                const SizedBox(height: 3),
                Text(xp,
                    style: const TextStyle(
                        color: _teal,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: _textSec, size: 20),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final _GoalStatus status;
  const _StatusDot({required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == _GoalStatus.done) {
      return Container(
        width: 28,
        height: 28,
        decoration:
            const BoxDecoration(color: _teal, shape: BoxShape.circle),
        child: const Icon(Icons.check, color: Colors.black, size: 16),
      );
    }
    if (status == _GoalStatus.active) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _teal, width: 2.5),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
                color: _teal, shape: BoxShape.circle),
          ),
        ),
      );
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _textSec, width: 2),
      ),
    );
  }
}

// ─── Quick Actions ────────────────────────────────────────────────────────────
class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: const [
        _ActionCard(
          icon: Icons.play_circle_outline_rounded,
          label: 'Watch Videos',
          color: Color(0xFF7B6DD6),
        ),
        _ActionCard(
          icon: Icons.quiz_outlined,
          label: 'Start Quiz',
          color: Color(0xFF7B6DD6),
        ),
        _ActionCard(
          icon: Icons.style_outlined,
          label: 'Flashcards',
          color: Color(0xFFF07A3A),
        ),
        _ActionCard(
          icon: Icons.auto_awesome_outlined,
          label: 'Daily Challenge',
          color: Color(0xFF4A7FD6),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ActionCard(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 10),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _textPri,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
