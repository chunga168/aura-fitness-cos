import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/aura_colors.dart';
import '../../../core/theme/aura_glass.dart';
import '../../habits/models/habit_model.dart';
import '../../habits/providers/habit_provider.dart';
import '../../profile/providers/user_profile_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);
    final userProfile = ref.watch(userProfileProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Home Screen retains the prominent "Aura" brand title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AURA',
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                            foreground: Paint()
                              ..shader = AuraColors.peakAuraGradient.createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                              ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Daily Micro-Habits & Vitality',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AuraColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // Streak Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AuraColors.surfaceContainerHigh.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AuraColors.softAmber.withOpacity(0.4),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AuraColors.softAmber.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            '${habitState.streakDays} Days',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AuraColors.ghostWhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Concentric Aura Energy Rings
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AuraGlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DAILY AURA ENERGY',
                            style: theme.textTheme.labelMedium?.copyWith(
                              letterSpacing: 1.2,
                              color: AuraColors.neonTeal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AuraColors.neonTeal.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '+${habitState.totalCompletedXp} XP',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AuraColors.neonTeal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Custom Concentric Rings
                      SizedBox(
                        height: 180,
                        width: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: const Size(180, 180),
                              painter: AuraConcentricRingsPainter(
                                progress: habitState.completionRate,
                                streakProgress: 0.8,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${(habitState.completionRate * 100).toInt()}%',
                                  style: theme.textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AuraColors.ghostWhite,
                                  ),
                                ),
                                Text(
                                  'Glow Level',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: AuraColors.lavenderGlow,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        habitState.completionRate == 1.0
                            ? '🎉 Aura Radiant! All daily micro-habits conquered!'
                            : '⚡ ${habitState.habits.where((h) => !h.isCompleted).length} micro-habits left to reach maximum Aura Radiance.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AuraColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Daily Micro-Habit Checklist
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MICRO-HABITS QUESTS',
                      style: theme.textTheme.labelMedium?.copyWith(
                        letterSpacing: 1.2,
                        color: AuraColors.textMuted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${habitState.habits.where((h) => h.isCompleted).length}/${habitState.habits.length}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AuraColors.lavenderGlow,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final habit = habitState.habits[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AuraGlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        backgroundColor: habit.isCompleted
                            ? AuraColors.electricViolet.withOpacity(0.12)
                            : null,
                        borderColor: habit.isCompleted
                            ? AuraColors.neonTeal.withOpacity(0.4)
                            : null,
                        onTap: () {
                          ref.read(habitProvider.notifier).toggleHabit(habit.id);
                          if (!habit.isCompleted) {
                            ref.read(userProfileProvider.notifier).addXp(habit.xpReward);
                          }
                        },
                        child: Row(
                          children: [
                            // Custom Animated Checkbox
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: habit.isCompleted
                                    ? AuraColors.peakAuraGradient
                                    : null,
                                color: habit.isCompleted
                                    ? null
                                    : AuraColors.surfaceContainerHigh.withOpacity(0.5),
                                border: Border.all(
                                  color: habit.isCompleted
                                      ? Colors.transparent
                                      : AuraColors.outlineVariant,
                                  width: 1.5,
                                ),
                              ),
                              child: habit.isCompleted
                                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                                  : Icon(habit.icon, size: 16, color: AuraColors.textMuted),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    habit.title,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      decoration: habit.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: habit.isCompleted
                                          ? AuraColors.textMuted
                                          : AuraColors.ghostWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    habit.description,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AuraColors.surfaceContainerHigh.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '+${habit.xpReward} XP',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AuraColors.lavenderGlow,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: habitState.habits.length,
                ),
              ),
            ),

            // Quick Weight & Metric Logger
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                child: AuraGlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.monitor_weight_outlined,
                                  color: AuraColors.neonTeal, size: 22),
                              const SizedBox(width: 10),
                              Text(
                                'CURRENT WEIGHT',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            habitState.latestWeight != null
                                ? '${habitState.latestWeight!.weightKg} kg'
                                : '-- kg',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: AuraColors.ghostWhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Track daily to calculate metabolic equilibrium & unlock weekly milestone badges.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AuraColors.neonTeal),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              _showLogWeightDialog(context, ref);
                            },
                            child: Text(
                              '+ Log Weight',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: AuraColors.neonTeal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogWeightDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: '74.0');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AuraColors.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Log Today\'s Weight (kg)',
              style: TextStyle(color: AuraColors.ghostWhite)),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              suffixText: 'kg',
              suffixStyle: TextStyle(color: AuraColors.neonTeal),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AuraColors.neonTeal),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AuraColors.textMuted)),
            ),
            AuraGradientButton(
              text: 'Save',
              height: 40,
              borderRadius: 20,
              onPressed: () {
                final val = double.tryParse(controller.text);
                if (val != null) {
                  ref.read(habitProvider.notifier).addWeightEntry(val);
                  ref.read(userProfileProvider.notifier).addXp(15);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

/// Concentric rings painter representing Habit & Streak Glow
class AuraConcentricRingsPainter extends CustomPainter {
  final double progress;
  final double streakProgress;

  AuraConcentricRingsPainter({
    required this.progress,
    required this.streakProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 8;
    final innerRadius = outerRadius - 18;

    // Track Backgrounds
    final bgPaint = Paint()
      ..color = AuraColors.surfaceContainerHighest.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(center, outerRadius, bgPaint);
    canvas.drawCircle(center, innerRadius, bgPaint);

    // Outer Ring: Daily Micro-Habits (Teal & Violet Gradient)
    final outerPaint = Paint()
      ..shader = const SweepGradient(
        colors: [AuraColors.neonTeal, AuraColors.electricViolet, AuraColors.neonTeal],
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      outerPaint,
    );

    // Inner Ring: Streak Aura (Lavender & Soft Amber)
    final innerPaint = Paint()
      ..color = AuraColors.lavenderGlow
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      -math.pi / 2,
      2 * math.pi * streakProgress,
      false,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AuraConcentricRingsPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.streakProgress != streakProgress;
  }
}
