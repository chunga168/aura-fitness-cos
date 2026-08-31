import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/aura_colors.dart';
import '../../../core/theme/aura_glass.dart';
import '../../habits/providers/habit_provider.dart';
import '../../workouts/providers/workout_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);
    final workoutState = ref.watch(workoutProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Streamlined Header (No redundant Aura title)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'History & Heatmap',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AuraColors.ghostWhite,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Consistency heatmaps & habit logs',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month_outlined,
                          color: AuraColors.neonTeal),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Top Consistency Stats Row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: AuraGlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CURRENT STREAK',
                                style: theme.textTheme.labelSmall?.copyWith(
                                    color: AuraColors.textMuted,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text('🔥', style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 6),
                                Text(
                                  '${habitState.streakDays} Days',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AuraColors.ghostWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AuraGlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TOTAL ACTIVE DAYS',
                                style: theme.textTheme.labelSmall?.copyWith(
                                    color: AuraColors.textMuted,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text('⚡', style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 6),
                                Text(
                                  '28 Days',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AuraColors.ghostWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Consistency Heatmap Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: AuraGlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MONTHLY CONSISTENCY MATRIX',
                            style: theme.textTheme.labelMedium?.copyWith(
                              letterSpacing: 1.1,
                              color: AuraColors.neonTeal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'August 2026',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AuraColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // 5-Week Grid Simulation
                      _buildHeatmapGrid(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Less', style: theme.textTheme.labelSmall),
                          const SizedBox(width: 6),
                          _heatmapPip(0),
                          _heatmapPip(1),
                          _heatmapPip(2),
                          _heatmapPip(3),
                          const SizedBox(width: 6),
                          Text('More Energy', style: theme.textTheme.labelSmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Workout History List
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  'COMPLETED SESSIONS',
                  style: theme.textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.2,
                    color: AuraColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final session = workoutState.pastWorkouts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AuraGlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AuraColors.neonTeal.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.check_circle_outline,
                                  color: AuraColors.neonTeal, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    session.title,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AuraColors.ghostWhite,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${session.durationMinutes} min • Total Volume ${session.totalVolumeKg.toInt()} kg',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AuraColors.surfaceContainerHigh.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '+${session.xpEarned} XP',
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
                  childCount: workoutState.pastWorkouts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatmapGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      final itemSize = (constraints.maxWidth - (6 * 6)) / 7;
      return Column(
        children: List.generate(4, (row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (col) {
                final dayNum = (row * 7) + col + 1;
                final intensity = (dayNum % 4);
                return Container(
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    color: _getColorForIntensity(intensity),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$dayNum',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: intensity > 1 ? Colors.white : AuraColors.textMuted,
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      );
    });
  }

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0:
        return AuraColors.surfaceContainerHighest.withOpacity(0.4);
      case 1:
        return AuraColors.neonTeal.withOpacity(0.3);
      case 2:
        return AuraColors.neonTeal.withOpacity(0.7);
      case 3:
      default:
        return AuraColors.neonTeal;
    }
  }

  Widget _heatmapPip(int intensity) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: _getColorForIntensity(intensity),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
