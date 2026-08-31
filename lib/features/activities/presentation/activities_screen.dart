import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/aura_colors.dart';
import '../../../core/theme/aura_glass.dart';
import '../../workouts/models/workout_model.dart';
import '../../workouts/providers/workout_provider.dart';
import '../../profile/providers/user_profile_provider.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          'Activities & Workouts',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AuraColors.ghostWhite,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Log sessions, volume & personal records',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune, color: AuraColors.textSecondary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Active Live Workout Banner (if active)
            if (workoutState.activeWorkout != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: AuraGlassCard(
                    padding: const EdgeInsets.all(20),
                    borderColor: AuraColors.neonTeal,
                    backgroundColor: AuraColors.electricViolet.withOpacity(0.18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AuraColors.neonTeal,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'ACTIVE WORKOUT IN PROGRESS',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: AuraColors.neonTeal,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              workoutState.activeWorkout!.location,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AuraColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          workoutState.activeWorkout!.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AuraColors.ghostWhite,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AuraColors.errorRed),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  ref.read(workoutProvider.notifier).cancelActiveWorkout();
                                },
                                child: const Text(
                                  'Discard',
                                  style: TextStyle(color: AuraColors.errorRed),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: AuraGradientButton(
                                text: 'Finish Workout',
                                height: 44,
                                borderRadius: 16,
                                onPressed: () {
                                  ref.read(workoutProvider.notifier).completeActiveWorkout();
                                  ref.read(userProfileProvider.notifier).addXp(135);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Quick Start Routine Banner (if no active workout)
            if (workoutState.activeWorkout == null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: AuraGlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ready to train?',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: AuraColors.ghostWhite,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Start an empty session or pick a custom routine.',
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 14),
                              AuraGradientButton(
                                text: '+ Quick Start Workout',
                                height: 42,
                                borderRadius: 16,
                                onPressed: () {
                                  ref.read(workoutProvider.notifier).startWorkout(
                                        'Chest & Arms Power',
                                        'Strength Zone',
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.fitness_center_rounded,
                          size: 56,
                          color: AuraColors.neonTeal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Muscle Group Target Filter
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  'MUSCLE GROUP FOCUS',
                  style: theme.textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.2,
                    color: AuraColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: MuscleGroup.values.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = workoutState.selectedFilter == null;
                      return ChoiceChip(
                        label: const Text('All Focus'),
                        selected: isSelected,
                        selectedColor: AuraColors.neonTeal.withOpacity(0.25),
                        backgroundColor: AuraColors.surfaceContainerHigh.withOpacity(0.6),
                        labelStyle: TextStyle(
                          color: isSelected ? AuraColors.neonTeal : AuraColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        side: BorderSide(
                          color: isSelected ? AuraColors.neonTeal : Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onSelected: (_) => ref.read(workoutProvider.notifier).setFilter(null),
                      );
                    }
                    final group = MuscleGroup.values[index - 1];
                    final isSelected = workoutState.selectedFilter == group;
                    return ChoiceChip(
                      label: Text(group.displayName),
                      selected: isSelected,
                      selectedColor: AuraColors.electricViolet.withOpacity(0.3),
                      backgroundColor: AuraColors.surfaceContainerHigh.withOpacity(0.6),
                      labelStyle: TextStyle(
                        color: isSelected ? AuraColors.lavenderGlow : AuraColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      side: BorderSide(
                        color: isSelected ? AuraColors.lavenderGlow : Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      onSelected: (_) => ref.read(workoutProvider.notifier).setFilter(group),
                    );
                  },
                ),
              ),
            ),

            // Past Workout Sessions List
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Text(
                  'RECENT WORKOUT LOGS',
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
                      padding: const EdgeInsets.only(bottom: 14),
                      child: AuraGlassCard(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      session.title,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: AuraColors.ghostWhite,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${session.durationMinutes} min • ${session.location}',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AuraColors.electricViolet.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(12),
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
                            const SizedBox(height: 12),
                            const Divider(color: AuraColors.outlineVariant, height: 1),
                            const SizedBox(height: 12),
                            // Exercises summary
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: session.exercises.map((ex) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AuraColors.surfaceContainerHigh.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${ex.name} (${ex.sets.length} sets)',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: AuraColors.textSecondary,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Volume: ${session.totalVolumeKg.toInt()} kg',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AuraColors.neonTeal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: AuraColors.textMuted,
                                  size: 18,
                                ),
                              ],
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
}
