import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/secure_payment.dart';


class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _CartAppBar(),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course item
                    AppCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'assets/logo_python.png',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Text('🐍',
                                    style: TextStyle(fontSize: 32)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Complete Python Masterclass',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 4),
                                Text('Dr. Sarah Chen',
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12)),
                                const SizedBox(height: 8),
                                Row(children: [
                                  const Text(
                                    '\$79.99',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '\$149.99',
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12,
                                      decoration:
                                          TextDecoration.lineThrough,
                                      decorationColor: Colors.white38,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.green.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      '-47%',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.delete_outline,
                                color: Colors.red, size: 18),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Promo code
                    AppCard(
                      child: Row(children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D3330),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.local_offer_outlined,
                              color: AppColors.accentCyan, size: 22),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: TextField(
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Enter Promo Code',
                              hintStyle: TextStyle(
                                  color: Colors.white38, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D3330),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.accentCyan
                                    .withOpacity(0.4)),
                          ),
                          child: Text(
                            'Apply',
                            style: TextStyle(
                                color: AppColors.accentCyan,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 12),

                    // Order summary
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 14),
                          _SummaryRow(
                              label: 'Subtotal', value: '\$149.99'),
                          const SizedBox(height: 8),
                          _SummaryRow(
                              label: 'Discount',
                              value: '-\$70.00',
                              valueColor: AppColors.accentCyan),
                          const SizedBox(height: 8),
                          _SummaryRow(
                              label: 'Platform Fee', value: '\$0.00'),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(color: Colors.white12),
                          ),
                          _SummaryRow(
                            label: 'Total',
                            value: '\$79.99',
                            isBold: true,
                            valueColor: AppColors.accentCyan,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Trust badges
                    _TrustBadge(
                        icon: Icons.lock_outline,
                        text: 'Secure checkout powered by SSL'),
                    const SizedBox(height: 8),
                    _TrustBadge(
                        icon: Icons.replay_outlined,
                        text: '30-day money-back guarantee'),
                    const SizedBox(height: 8),
                    _TrustBadge(
                        icon: Icons.all_inclusive,
                        text: 'Lifetime access to course content'),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom bar
            _BottomActionBar(
              label: 'Continue to Payment',
              total: '\$79.99',
              onTap: () => Get.to(() => const SecurePaymentScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _CartAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            'My Cart',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 28),
      ]),
    );
  }
}

// ─── Summary Row ──────────────────────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: isBold ? Colors.white : Colors.white54,
                fontSize: isBold ? 15 : 13,
                fontWeight:
                    isBold ? FontWeight.w700 : FontWeight.w400)),
        Text(value,
            style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: isBold ? 16 : 13,
                fontWeight:
                    isBold ? FontWeight.w800 : FontWeight.w500)),
      ],
    );
  }
}

// ─── Trust Badge ──────────────────────────────────────────────────────────────

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  const _TrustBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: Colors.white38, size: 18),
      const SizedBox(width: 10),
      Text(text,
          style: const TextStyle(color: Colors.white38, fontSize: 13)),
    ]);
  }
}

// ─── Bottom Action Bar ────────────────────────────────────────────────────────

class _BottomActionBar extends StatelessWidget {
  final String label;
  final String total;
  final VoidCallback onTap;
  const _BottomActionBar({
    required this.label,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total (1 item)',
                style: TextStyle(color: Colors.white54, fontSize: 13)),
            Text(total,
                style: TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 18,
                    fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentCyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 0,
            ),
            child: Text(label,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ]),
    );
  }
}