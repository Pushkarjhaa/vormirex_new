import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vormirex_new/utils/app_colour.dart';
import 'package:vormirex_new/utils/widget.dart';
import 'package:vormirex_new/view/payment_sucess_screen.dart';


class SecurePaymentScreen extends StatefulWidget {
  const SecurePaymentScreen({super.key});

  @override
  State<SecurePaymentScreen> createState() => _SecurePaymentScreenState();
}

class _SecurePaymentScreenState extends State<SecurePaymentScreen> {
  int _selectedMethod = 0;

  final List<_PayMethod> _methods = const [
    _PayMethod(
        icon: Icons.payment,
        label: 'UPI',
        sub: 'Pay using any UPI app'),
    _PayMethod(
        icon: Icons.credit_card,
        label: 'Credit/Debit Card',
        sub: 'Visa, Mastercard, Rupay'),
    _PayMethod(
        icon: Icons.account_balance,
        label: 'Net Banking',
        sub: 'All major banks'),
    _PayMethod(
        icon: Icons.account_balance_wallet_outlined,
        label: 'Wallet',
        sub: 'Paytm, PhonePe, Amazon Pay'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.cardBg,
                border:
                    Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.chevron_left,
                      color: Colors.white, size: 28),
                ),
                const Expanded(
                  child: Text(
                    'Secure Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 28),
              ]),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    // Amount card
                    AppCard(
                      child: Column(children: [
                        const Text('Amount to Pay',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                          '\$79.99',
                          style: TextStyle(
                              color: AppColors.accentCyan,
                              fontSize: 36,
                              fontWeight: FontWeight.w800),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 14),

                    // Payment method tiles
                    ...List.generate(_methods.length, (i) {
                      final isActive = i == _selectedMethod;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedMethod = i),
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF0D3330)
                                  : AppColors.cardBg,
                              borderRadius:
                                  BorderRadius.circular(14),
                              border: Border.all(
                                color: isActive
                                    ? AppColors.accentCyan
                                    : Colors.white10,
                                width: isActive ? 1.5 : 1,
                              ),
                            ),
                            child: Row(children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.accentCyan
                                          .withOpacity(0.15)
                                      : Colors.white10,
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  _methods[i].icon,
                                  color: isActive
                                      ? AppColors.accentCyan
                                      : Colors.white54,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(_methods[i].label,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeight.w700)),
                                    Text(_methods[i].sub,
                                        style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              // Radio indicator
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isActive
                                        ? AppColors.accentCyan
                                        : Colors.white24,
                                    width: 2,
                                  ),
                                ),
                                child: isActive
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.accentCyan,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ]),
                          ),
                        ),
                      );
                    }),

                    // UPI ID field (only when UPI selected)
                    if (_selectedMethod == 0) ...[
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Enter UPI ID',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBg,
                                borderRadius:
                                    BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white12),
                              ),
                              child: const TextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'yourname@upi',
                                  hintStyle: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 14),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(children: [
                              Icon(Icons.verified_user_outlined,
                                  color: AppColors.accentCyan,
                                  size: 16),
                              const SizedBox(width: 6),
                              const Text(
                                'Your UPI ID is encrypted and secure',
                                style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: const BoxDecoration(
                color: AppColors.cardBg,
                border:
                    Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total (1 item)',
                        style: TextStyle(
                            color: Colors.white54, fontSize: 13)),
                    Text('\$79.99',
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
                    onPressed: () => Get.to(
                        () => const PaymentSuccessfulScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentCyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Pay \$79.99 Securely',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'By continuing, you agree to our Terms of Service',
                  style:
                      TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _PayMethod {
  final IconData icon;
  final String label;
  final String sub;
  const _PayMethod(
      {required this.icon, required this.label, required this.sub});
}