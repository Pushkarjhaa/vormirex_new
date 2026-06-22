import 'dart:math' as math;
import 'package:flutter/material.dart';

// ─── Palette ──────────────────────────────────────────────────────────────────
const _card   = Color(0xFF111A28);
const _border = Color(0xFF1E2A38);
const _teal   = Color(0xFF3CD9C3);
const _textPri = Colors.white;
const _textSec = Color(0xFF7A7A9A);

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

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

            const SizedBox(height: 24),

            // ── XP Circle ────────────────────────────────────────────────
            const _XpCircleSection(),

            const SizedBox(height: 22),

            // ── Stats Row ────────────────────────────────────────────────
            const _StatsRow(),

            const SizedBox(height: 22),

            // ── Learning Activity ────────────────────────────────────────
            const _LearningActivity(),

            const SizedBox(height: 22),

            // ── Subject Performance ──────────────────────────────────────
            _sectionLabel('SUBJECT PERFORMANCE'),
            const SizedBox(height: 12),
            const _SubjectBar(label: 'Quantum Physics',    percent: '78%', value: 0.78, color: _teal),
            const SizedBox(height: 10),
            const _SubjectBar(label: 'Advanced Algebra',  percent: '92%', value: 0.92, color: _teal),
            const SizedBox(height: 10),
            const _SubjectBar(label: 'JavaScript Mastery',percent: '44%', value: 0.44, color: Colors.redAccent),

            const SizedBox(height: 22),

            // ── Top Learners ─────────────────────────────────────────────
            _sectionLabel('TOP LEARNERS'),
            const SizedBox(height: 12),
            const _TopLearners(),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.menu, color: _textPri, size: 22),
        const SizedBox(width: 12),
        const Text(
          'Progress',
          style: TextStyle(
            color: _textPri,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
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

  static Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: _textSec,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }
}

// ─── XP Circle Section ────────────────────────────────────────────────────────
class _XpCircleSection extends StatelessWidget {
  const _XpCircleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circular XP progress
        SizedBox(
          width: 175,
          height: 175,
          child: CustomPaint(
            painter: _ArcPainter(progress: 0.85),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '85%',
                    style: TextStyle(
                      color: _teal,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '4250 / 5000 XP',
                    style: TextStyle(color: _textSec, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // "Keep it up!"
        const Text(
          'Keep it up!',
          style: TextStyle(
            color: _teal,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        // Motivational quote
        Text(
          '"You\'re only 750 XP away from your\nweekly goal. Your focus on JavaScript\nis really paying off!"',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _textPri.withValues(alpha: 0.65),
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  const _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = _teal.withValues(alpha: 0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    // Arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = _teal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) => old.progress != progress;
}

// ─── Stats Row ────────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _StatCard(label: 'STREAK',   value: '12d',   icon: Icons.local_fire_department),
        SizedBox(width: 10),
        _StatCard(label: 'TOTAL XP', value: '24.5k', icon: Icons.bolt),
        SizedBox(width: 10),
        _StatCard(label: 'RANK',     value: '#42',   icon: Icons.emoji_events_outlined),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _textSec,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: _textPri,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Icon(icon, color: _teal, size: 18),
          ],
        ),
      ),
    );
  }
}

// ─── Learning Activity ────────────────────────────────────────────────────────
class _LearningActivity extends StatelessWidget {
  const _LearningActivity();

  static const _days   = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _values = [0.50, 0.70, 0.85, 1.00, 0.60, 0.40, 0.30];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        children: [
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'LEARNING ACTIVITY',
                style: TextStyle(
                  color: _textSec,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'Last 7 Days',
                style: TextStyle(color: _textSec, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // bars
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isMax = _values[i] == 1.0;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: _values[i],
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: isMax
                                      ? [_teal, const Color(0xFF80FFF5)]
                                      : [
                                          _teal.withValues(alpha: 0.45),
                                          _teal.withValues(alpha: 0.70),
                                        ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _days[i],
                          style: TextStyle(
                            color: isMax ? _teal : _textSec,
                            fontSize: 10,
                            fontWeight: isMax ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Subject Bar ──────────────────────────────────────────────────────────────
class _SubjectBar extends StatelessWidget {
  final String label;
  final String percent;
  final double value;
  final Color color;

  const _SubjectBar({
    required this.label,
    required this.percent,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _textPri,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                percent,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 5,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Top Learners ─────────────────────────────────────────────────────────────
class _TopLearners extends StatelessWidget {
  const _TopLearners();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _LearnerRow(rank: 1, name: 'Elena K.',  xp: '12,840 XP', isYou: false),
        SizedBox(height: 8),
        _LearnerRow(rank: 2, name: 'Marcus T.', xp: '11,200 XP', isYou: false),
        SizedBox(height: 8),
        _LearnerRow(rank: 4, name: 'You',       xp: '8,450 XP',  isYou: true),
      ],
    );
  }
}

class _LearnerRow extends StatelessWidget {
  final int rank;
  final String name;
  final String xp;
  final bool isYou;

  const _LearnerRow({
    required this.rank,
    required this.name,
    required this.xp,
    required this.isYou,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isYou ? _teal.withValues(alpha: 0.10) : _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isYou ? _teal.withValues(alpha: 0.4) : _border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Rank number
          SizedBox(
            width: 24,
            child: Text(
              '$rank',
              style: TextStyle(
                color: isYou ? _teal : _textSec,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isYou
                  ? _teal.withValues(alpha: 0.2)
                  : const Color(0xFF1E2A38),
              border: Border.all(
                color: isYou ? _teal : _border,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.person,
              color: isYou ? _teal : _textSec,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Name
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isYou ? _teal : _textPri,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // XP
          Text(
            xp,
            style: TextStyle(
              color: isYou ? _teal : _textSec,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
