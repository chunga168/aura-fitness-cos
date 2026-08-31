import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit_model.dart';

class HabitState {
  final List<MicroHabit> habits;
  final List<WeightEntry> weightHistory;
  final int streakDays;
  final int streakFreezesRemaining;

  const HabitState({
    required this.habits,
    required this.weightHistory,
    this.streakDays = 5,
    this.streakFreezesRemaining = 2,
  });

  double get completionRate {
    if (habits.isEmpty) return 0.0;
    final completed = habits.where((h) => h.isCompleted).length;
    return completed / habits.length;
  }

  int get totalCompletedXp {
    return habits
        .where((h) => h.isCompleted)
        .fold(0, (sum, item) => sum + item.xpReward);
  }

  WeightEntry? get latestWeight =>
      weightHistory.isNotEmpty ? weightHistory.first : null;

  HabitState copyWith({
    List<MicroHabit>? habits,
    List<WeightEntry>? weightHistory,
    int? streakDays,
    int? streakFreezesRemaining,
  }) {
    return HabitState(
      habits: habits ?? this.habits,
      weightHistory: weightHistory ?? this.weightHistory,
      streakDays: streakDays ?? this.streakDays,
      streakFreezesRemaining:
          streakFreezesRemaining ?? this.streakFreezesRemaining,
    );
  }
}

class HabitNotifier extends StateNotifier<HabitState> {
  HabitNotifier()
      : super(
          HabitState(
            habits: [
              const MicroHabit(
                id: 'h1',
                title: 'Morning Hydration (500ml)',
                description: 'Kickstart metabolic rate upon waking',
                category: HabitCategory.hydration,
                xpReward: 25,
                isCompleted: true,
                icon: Icons.water_drop_outlined,
              ),
              const MicroHabit(
                id: 'h2',
                title: '10-Minute Mobility & Stretch',
                description: 'Spine & hip dynamic opener',
                category: HabitCategory.movement,
                xpReward: 35,
                isCompleted: true,
                icon: Icons.accessibility_new_outlined,
              ),
              const MicroHabit(
                id: 'h3',
                title: 'High Protein Lunch (+30g)',
                description: 'Nutrient-dense muscle synthesis meal',
                category: HabitCategory.nutrition,
                xpReward: 40,
                isCompleted: false,
                icon: Icons.restaurant_outlined,
              ),
              const MicroHabit(
                id: 'h4',
                title: 'Evening Mindful Decompression',
                description: '5 min breathwork or gratitude journal',
                category: HabitCategory.mindfulness,
                xpReward: 20,
                isCompleted: false,
                icon: Icons.nightlight_round_outlined,
              ),
            ],
            weightHistory: [
              WeightEntry(
                id: 'w1',
                weightKg: 74.2,
                recordedAt: DateTime.now().subtract(const Duration(days: 0)),
              ),
              WeightEntry(
                id: 'w2',
                weightKg: 74.5,
                recordedAt: DateTime.now().subtract(const Duration(days: 1)),
              ),
              WeightEntry(
                id: 'w3',
                weightKg: 74.9,
                recordedAt: DateTime.now().subtract(const Duration(days: 3)),
              ),
              WeightEntry(
                id: 'w4',
                weightKg: 75.3,
                recordedAt: DateTime.now().subtract(const Duration(days: 6)),
              ),
            ],
          ),
        );

  void toggleHabit(String id) {
    state = state.copyWith(
      habits: state.habits.map((habit) {
        if (habit.id == id) {
          return habit.copyWith(isCompleted: !habit.isCompleted);
        }
        return habit;
      }).toList(),
    );
  }

  void addWeightEntry(double weightKg, {String? note}) {
    final entry = WeightEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      weightKg: weightKg,
      recordedAt: DateTime.now(),
      note: note,
    );
    state = state.copyWith(
      weightHistory: [entry, ...state.weightHistory],
    );
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, HabitState>((ref) {
  return HabitNotifier();
});
