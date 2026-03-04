import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/my_cart_screen.dart';


class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.cardBg,
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.chevron_left,
                      color: Colors.white, size: 28),
                ),
                const Expanded(
                  child: Text(
                    'Courses Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      setState(() => _isWishlisted = !_isWishlisted),
                  child: Icon(
                    _isWishlisted
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: _isWishlisted ? Colors.red : Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 18),
                const Icon(Icons.share_outlined,
                    color: Colors.white, size: 22),
              ]),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course image
                    Center(
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/logo_python.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Text('🐍',
                                style: TextStyle(fontSize: 60)),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    const Center(
                      child: Text(
                        'Complete Python\nMasterclass',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Author
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'By ',
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Dr. Sarah Chen',
                              style: TextStyle(
                                  color: AppColors.accentCyan,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Stars
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                              4,
                              (_) => const Icon(Icons.star,
                                  color: Colors.amber, size: 18)),
                          const Icon(Icons.star_border,
                              color: Colors.amber, size: 18),
                          const SizedBox(width: 8),
                          const Text('4.8',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                          Text(' (2,847 reviews)',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 13)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Stats row
                    Row(children: [
                      _StatBox(
                          icon: Icons.access_time,
                          value: '24H',
                          label: 'Total Hours'),
                      const SizedBox(width: 10),
                      _StatBox(
                          icon: Icons.menu_book_outlined,
                          value: '48',
                          label: 'Lessons'),
                      const SizedBox(width: 10),
                      _StatBox(
                          icon: Icons.people_outline,
                          value: '15K',
                          label: 'Students'),
                    ]),

                    const SizedBox(height: 16),

                    // About
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('About this course',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Text(
                            'Master the art of creating stunning user interfaces and seamless user experiences. Learn design principles, prototyping, user research, and industry-standard tools like Figma and Adobe XD from a senior designer at a Fortune 500 company.',
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 13,
                                height: 1.6),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // What you'll learn
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("What you'll learn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 12),
                          ...List.generate(
                            4,
                            (_) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle,
                                      color: AppColors.accentCyan,
                                      size: 18),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Design thinking and user-centered design',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$149.99',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white38,
                              ),
                            ),
                            const Text(
                              '\$79.99',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.accentCyan,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '47% OFF',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 13),
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
                        onPressed: () =>
                            Get.to(() => const MyCartScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentCyan,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Add Course to Cart',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat Box ─────────────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatBox(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Icon(icon, color: AppColors.accentCyan, size: 20),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white38, fontSize: 11)),
        ]),
      ),
    );
  }
}