import 'package:flutter/material.dart';



// ─── Color Palette ───────────────────────────────────────────────────────────
class AppColors {
  static const background   = Color(0xFF1A1A1A);
  static const cardBg       = Color(0xFF232323);
  static const cardBorder   = Color(0xFF2A3540);
  static const cyan         = Color(0xFF00FFFF);
  static const cyanDim      = Color(0x2200FFFF);
  static const cyanBorder   = Color(0x4400FFFF);
  static const textPrimary  = Color(0xFFE8F2FA);
  static const textSecondary= Color(0xFF6B7A8D);
  static const textMuted    = Color(0xFF3A4A58);
  static const starColor    = Color(0xFFF4C542);
  static const beginnerColor= Color(0xFF00FFFF);
  static const intermediateColor = Color(0xFFF4A261);
  static const advancedColor = Color(0xFFE76F51);
}

// ─── Home Screen ─────────────────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Header
              _buildHeader(),
              const SizedBox(height: 20),
              // Daily Goal Card
              _buildDailyGoalCard(),
              const SizedBox(height: 24),
              // Continue Learning Section
              _buildSectionTitle('Continue Learning'),
              const SizedBox(height: 12),
              _buildContinueLearningCard(),
              const SizedBox(height: 24),
              // Recommended Section
              _buildRecommendedHeader(),
              const SizedBox(height: 12),
              _buildCourseCard(
                title: 'Python Fundamentals',
                level: 'Beginner',
                levelColor: AppColors.beginnerColor,
                hours: '24H',
                lessons: '48 lessons',
                rating: '4.9',
                students: '45.2k students',
              ),
              const SizedBox(height: 10),
              _buildCourseCard(
                title: 'Python Fundamentals',
                level: 'Intermediate',
                levelColor: AppColors.intermediateColor,
                hours: '6H',
                lessons: '48 lessons',
                rating: '4.8',
                students: '45.2k students',
              ),
              const SizedBox(height: 10),
              _buildCourseCard(
                title: 'Python Fundamentals',
                level: 'Advanced',
                levelColor: AppColors.advancedColor,
                hours: '24H',
                lessons: '48 lessons',
                rating: '4.9',
                students: '45.2k students',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening,',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Welcome, Pushkar!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          // 3-dot menu
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1E252C),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.textSecondary, size: 18),
              color: const Color(0xFF1E252C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: (value) {},
              itemBuilder: (context) => [
                _popupItem('Profile', Icons.person_outline),
                _popupItem('Settings', Icons.settings_outlined),
                _popupItem('Help', Icons.help_outline),
                _popupItem('Logout', Icons.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _popupItem(String label, IconData icon) {
    return PopupMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 16),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
        ],
      ),
    );
  }

  // ── Daily Goal Card ───────────────────────────────────────────────────────
  Widget _buildDailyGoalCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1B22),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cyanBorder, width: 1),
          // Top glow line
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
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.cyanDim,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.timer_outlined, color: AppColors.cyan, size: 16),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Daily Goal',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '70%',
                  style: TextStyle(
                    color: AppColors.cyan,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: 0.70,
                minHeight: 6,
                backgroundColor: const Color(0xFF1A2A35),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '35 min / 50 min completed',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Title ─────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  // ── Continue Learning Card ────────────────────────────────────────────────
  Widget _buildContinueLearningCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left accent bar
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
                        colors: [AppColors.cyan, Color(0xFF0077B6)],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Complete Python Masterclass',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.book_outlined, color: AppColors.textMuted, size: 13),
                            const SizedBox(width: 4),
                            Text(
                              '8 of 12 lessons',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.access_time, color: AppColors.textMuted, size: 13),
                            const SizedBox(width: 4),
                            Text(
                              '45 min left',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                            ),
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
              child: LinearProgressIndicator(
                value: 0.66,
                minHeight: 5,
                backgroundColor: const Color(0xFF1A2230),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyan,
                  foregroundColor: const Color(0xFF0A0C0F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue Learning',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Recommended Header ────────────────────────────────────────────────────
  Widget _buildRecommendedHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recommended',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            'See All',
            style: const TextStyle(
              color: AppColors.cyan,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ── Course Card ───────────────────────────────────────────────────────────
  Widget _buildCourseCard({
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
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1A2230), width: 1),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF111E2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('🐍', style: TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFD4DDE8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      // Level badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: levelColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: levelColor.withOpacity(0.3), width: 1),
                        ),
                        child: Text(
                          level,
                          style: TextStyle(
                            color: levelColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.access_time, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(hours, style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      const SizedBox(width: 8),
                      Icon(Icons.menu_book_outlined, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(lessons, style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.starColor, size: 13),
                      const SizedBox(width: 3),
                      Text(
                        rating,
                        style: const TextStyle(
                          color: AppColors.starColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.people_outline, size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(students, style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
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