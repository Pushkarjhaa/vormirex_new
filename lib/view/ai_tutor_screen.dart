import 'dart:math' as math;
import 'package:flutter/material.dart';

// ─── Palette ──────────────────────────────────────────────────────────────────
const _card   = Color(0xFF111A28);
const _border = Color(0xFF1E2A38);
const _teal   = Color(0xFF3CD9C3);
const _textPri = Colors.white;
const _textSec = Color(0xFF7A7A9A);
const _green   = Color(0xFF4ADE80);

// ─── Answer options ───────────────────────────────────────────────────────────
const _answers = [
  "The other particle's state remains uncertain until measured independently.",
  "The other particle immediately assumes a corresponding state.",
  "Information is transmitted through hidden variables at luminal speed.",
  "Wave function collapse is delayed by the distance between observers.",
];

// ─── Screen ───────────────────────────────────────────────────────────────────
class AITutorScreen extends StatefulWidget {
  const AITutorScreen({super.key});

  @override
  State<AITutorScreen> createState() => _AITutorScreenState();
}

class _AITutorScreenState extends State<AITutorScreen> {
  int? _selected;

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

            const SizedBox(height: 18),

            // ── Difficulty + XP row ──────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: _teal.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: _teal.withValues(alpha: 0.45), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.shield_outlined, color: _teal, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'ELITE DIFFICULTY',
                        style: TextStyle(
                          color: _teal,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '+500 XP',
                  style: TextStyle(
                    color: _teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Circular Timer ───────────────────────────────────────────
            const Center(child: _TimerWidget()),

            const SizedBox(height: 28),

            // ── Question Card ────────────────────────────────────────────
            const _QuestionCard(),

            const SizedBox(height: 14),

            // ── Answer Options ───────────────────────────────────────────
            ...List.generate(
              _answers.length,
              (i) => _AnswerOption(
                text: _answers[i],
                isSelected: _selected == i,
                onTap: () => setState(() => _selected = i),
              ),
            ),

            const SizedBox(height: 28),

            // ── History ──────────────────────────────────────────────────
            const _HistorySection(),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset('assets/new_logo.png', width: 26, height: 26),
        const SizedBox(width: 8),
        const Text(
          'AI Tutor',
          style: TextStyle(
            color: _textPri,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        // XP badge
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border),
          ),
          child: Row(
            children: const [
              Icon(Icons.monetization_on_outlined,
                  color: _teal, size: 15),
              SizedBox(width: 4),
              Text(
                '2,450',
                style: TextStyle(
                  color: _textPri,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _card,
            border: Border.all(color: _teal, width: 1.5),
          ),
          child: const Icon(Icons.person, color: _teal, size: 20),
        ),
      ],
    );
  }
}

// ─── Circular Timer ───────────────────────────────────────────────────────────
class _TimerWidget extends StatelessWidget {
  const _TimerWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 170,
      child: CustomPaint(
        painter: _TimerPainter(progress: 0.50),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '14:59',
                style: TextStyle(
                  color: _textPri,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'TIME REMAINING',
                style: TextStyle(
                  color: _textSec,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  final double progress;
  const _TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Track
    final track = Paint()
      ..color = _teal.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9;
    canvas.drawCircle(center, radius, track);

    // Progress arc
    final arc = Paint()
      ..color = _teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerPainter old) =>
      old.progress != progress;
}

// ─── Question Card ────────────────────────────────────────────────────────────
class _QuestionCard extends StatelessWidget {
  const _QuestionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category label
          Row(
            children: const [
              Icon(Icons.science_outlined, color: _teal, size: 14),
              SizedBox(width: 6),
              Text(
                'QUANTUM PHYSICS',
                style: TextStyle(
                  color: _teal,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Title
          const Text(
            'Quantum\nEntanglement',
            style: TextStyle(
              color: _textPri,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          // Question body
          Text(
            'According to the EPR paradox, if two particles are entangled, what occurs when the spin of one particle is measured?',
            style: TextStyle(
              color: _textPri.withValues(alpha: 0.7),
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Answer Option ────────────────────────────────────────────────────────────
class _AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? _teal.withValues(alpha: 0.10) : _card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _teal.withValues(alpha: 0.5) : _border,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? _teal : _textPri,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

// ─── History Section ──────────────────────────────────────────────────────────
class _HistorySection extends StatelessWidget {
  const _HistorySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HISTORY',
          style: TextStyle(
            color: _textSec,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            _HistoryItem(day: 'Mon, Oct 14', success: true),
            SizedBox(width: 20),
            _HistoryItem(day: 'Tue, Oct 15', success: false),
            SizedBox(width: 20),
            _HistoryItem(day: 'Wed, Oct 16', success: true),
          ],
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String day;
  final bool success;
  const _HistoryItem({required this.day, required this.success});

  @override
  Widget build(BuildContext context) {
    final color = success ? _green : Colors.redAccent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(day,
            style: const TextStyle(color: _textSec, fontSize: 11)),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              success ? Icons.check_circle : Icons.cancel,
              color: color,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              success ? 'Success' : 'Missed',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
