import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/view/ai_tutor_screen.dart';
import 'package:vormirex_new/view/course_screen.dart';
import 'package:vormirex_new/view/homescreen.dart';
import 'package:vormirex_new/view/profile_screen.dart';
import 'package:vormirex_new/view/progress.screen.dart' show ProgressScreen;


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CoursesScreen(),
    AITutorScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: _screens[_currentIndex],
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home_outlined, label: 'Home'),
      _NavItem(icon: Icons.menu_book_outlined, label: 'Courses'),
      _NavItem(icon: Icons.smart_toy_outlined, label: 'AI Tutor'),
      _NavItem(icon: Icons.bar_chart_outlined, label: 'Progress'),
      _NavItem(icon: Icons.person_outline, label: 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(top: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (i) {
              final isActive = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.accentCyan.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          items[i].icon,
                          color: isActive ? AppColors.accentCyan : Colors.white38,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive ? AppColors.accentCyan : Colors.white38,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
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
  final String label;
  const _NavItem({required this.icon, required this.label});
}