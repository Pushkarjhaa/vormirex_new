import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/ai_tutor_screen.dart';
import 'package:vormirex_new/view/course_screen.dart';
import 'package:vormirex_new/view/profile_screen.dart';
import 'package:vormirex_new/view/progress.screen.dart';

// ─── Color Palette ────────────────────────────────────────────────────────────
class _C {
  static const background        = Color(0xFF1A1A1A);
  static const cardBorder        = Color(0xFF2A3540);
  static const cyan              = Color(0xFF00FFFF);
  static const cyanDim           = Color(0x2200FFFF);
  static const cyanBorder        = Color(0x4400FFFF);
  static const textPrimary       = Color(0xFFE8F2FA);
  static const textSecondary     = Color(0xFF6B7A8D);
  static const textMuted         = Color(0xFF3A4A58);
  static const starColor         = Color(0xFFF4C542);
  static const beginnerColor     = Color(0xFF00FFFF);
  static const intermediateColor = Color(0xFFF4A261);
  static const advancedColor     = Color(0xFFE76F51);
  static const menuBg            = Color(0xFF1E252C);
  static const darkCard          = Color(0xFF0D1117);
  static const darkGoal          = Color(0xFF0F1B22);
}

// ─── Nav Destinations ─────────────────────────────────────────────────────────
enum _Dest { courses, aiTutor, progress, profile }

// ─── New Home Screen (shell) ──────────────────────────────────────────────────
class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  _Dest? _active; // null = home

  void _go(_Dest d) => setState(() => _active = d);
  void _home()      => setState(() => _active = null);

  Widget _body() {
    switch (_active) {
      case _Dest.courses:  return CoursesScreen();
      case _Dest.aiTutor:  return const AITutorScreen();
      case _Dest.progress: return const ProgressScreen();
      case _Dest.profile:  return const ProfileScreen();
      case null:           return _HomeContent(onNavigate: _go);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // allow system back only when on home; otherwise pop to home
      canPop: _active == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _home();
      },
      child: Scaffold(
        backgroundColor: _C.background,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: KeyedSubtree(key: ValueKey(_active), child: _body()),
        ),
      ),
    );
  }
}

// ─── Home Content ─────────────────────────────────────────────────────────────
class _HomeContent extends StatelessWidget {
  final void Function(_Dest) onNavigate;
  const _HomeContent({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _header(),
            const SizedBox(height: 20),
            _dailyGoalCard(),
            const SizedBox(height: 24),
            _sectionTitle('Continue Learning'),
            const SizedBox(height: 12),
            _continueLearningCard(),
            const SizedBox(height: 24),
            _recommendedHeader(),
            const SizedBox(height: 12),
            _courseCard(
              title: 'Python Fundamentals',
              level: 'Beginner',
              levelColor: _C.beginnerColor,
              hours: '24H', lessons: '48 lessons',
              rating: '4.9', students: '45.2k students',
            ),
            const SizedBox(height: 10),
            _courseCard(
              title: 'Python Fundamentals',
              level: 'Intermediate',
              levelColor: _C.intermediateColor,
              hours: '6H', lessons: '48 lessons',
              rating: '4.8', students: '45.2k students',
            ),
            const SizedBox(height: 10),
            _courseCard(
              title: 'Python Fundamentals',
              level: 'Advanced',
              levelColor: _C.advancedColor,
              hours: '24H', lessons: '48 lessons',
              rating: '4.9', students: '45.2k students',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening,',
                style: TextStyle(
                  fontSize: 14,
                  color: _C.textSecondary,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Welcome, Pushkar!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _C.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          // 3-dot popup menu
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _C.menuBg,
              border: Border.all(color: _C.cardBorder, width: 1),
            ),
            child: PopupMenuButton<_Dest>(
              icon: const Icon(Icons.more_vert, color: _C.textSecondary, size: 18),
              color: _C.menuBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: onNavigate,
              itemBuilder: (_) => [
                _menuItem(_Dest.courses,  'Courses',   Icons.menu_book_outlined),
                _menuItem(_Dest.aiTutor,  'AI Tutor',  Icons.smart_toy_outlined),
                _menuItem(_Dest.progress, 'Progress',  Icons.bar_chart_outlined),
                _menuItem(_Dest.profile,  'Profile',   Icons.person_outline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_Dest> _menuItem(_Dest value, String label, IconData icon) {
    return PopupMenuItem<_Dest>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: _C.textSecondary, size: 16),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: _C.textPrimary, fontSize: 13)),
        ],
      ),
    );
  }

  // ── Daily Goal Card ───────────────────────────────────────────────────────
  Widget _dailyGoalCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _C.cyanBorder, width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D2030), Color(0xFF0A1218)],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30, height: 30,
                      decoration: BoxDecoration(
                        color: _C.cyanDim,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.timer_outlined, color: _C.cyan, size: 16),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Daily Goal',
                      style: TextStyle(color: _C.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Text(
                  '70%',
                  style: TextStyle(color: _C.cyan, fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: const LinearProgressIndicator(
                value: 0.70,
                minHeight: 6,
                backgroundColor: Color(0xFF1A2A35),
                valueColor: AlwaysStoppedAnimation<Color>(_C.cyan),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '35 min / 50 min completed',
                style: TextStyle(color: _C.textMuted, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Title ─────────────────────────────────────────────────────────
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: _C.textPrimary, fontSize: 17,
          fontWeight: FontWeight.w700, letterSpacing: -0.3,
        ),
      ),
    );
  }

  // ── Continue Learning Card ────────────────────────────────────────────────
  Widget _continueLearningCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _C.darkCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _C.cardBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 3,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [_C.cyan, Color(0xFF0077B6)],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Complete Python Masterclass',
                          style: TextStyle(
                            color: _C.textPrimary, fontSize: 15, fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.book_outlined, color: _C.textMuted, size: 13),
                            SizedBox(width: 4),
                            Text('8 of 12 lessons', style: TextStyle(color: _C.textMuted, fontSize: 12)),
                            SizedBox(width: 12),
                            Icon(Icons.access_time, color: _C.textMuted, size: 13),
                            SizedBox(width: 4),
                            Text('45 min left', style: TextStyle(color: _C.textMuted, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: const LinearProgressIndicator(
                value: 0.66,
                minHeight: 5,
                backgroundColor: Color(0xFF1A2230),
                valueColor: AlwaysStoppedAnimation<Color>(_C.cyan),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _C.cyan,
                  foregroundColor: const Color(0xFF0A0C0F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue Learning',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Recommended Header ────────────────────────────────────────────────────
  Widget _recommendedHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recommended',
            style: TextStyle(
              color: _C.textPrimary, fontSize: 17,
              fontWeight: FontWeight.w700, letterSpacing: -0.3,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(color: _C.cyan, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ── Course Card ───────────────────────────────────────────────────────────
  Widget _courseCard({
    required String title,
    required String level,
    required Color levelColor,
    required String hours,
    required String lessons,
    required String rating,
    required String students,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _C.darkCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1A2230), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF111E2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('🐍', style: TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFD4DDE8), fontSize: 14, fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: levelColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: levelColor.withOpacity(0.3), width: 1),
                        ),
                        child: Text(
                          level,
                          style: TextStyle(color: levelColor, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 11, color: _C.textMuted),
                      const SizedBox(width: 3),
                      Text(hours, style: const TextStyle(color: _C.textMuted, fontSize: 11)),
                      const SizedBox(width: 8),
                      const Icon(Icons.menu_book_outlined, size: 11, color: _C.textMuted),
                      const SizedBox(width: 3),
                      Text(lessons, style: const TextStyle(color: _C.textMuted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: _C.starColor, size: 13),
                      const SizedBox(width: 3),
                      Text(
                        rating,
                        style: const TextStyle(color: _C.starColor, fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.people_outline, size: 12, color: _C.textMuted),
                      const SizedBox(width: 3),
                      Text(students, style: const TextStyle(color: _C.textMuted, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF2A3A4A), size: 20),
          ],
        ),
      ),
    );
  }
}