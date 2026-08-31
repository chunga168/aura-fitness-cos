import 'package:flutter/material.dart';

enum HabitCategory {
  nutrition,
  hydration,
  movement,
  recovery,
  mindfulness,
}

class MicroHabit {
  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final int xpReward;
  final bool isCompleted;
  final IconData icon;

  const MicroHabit({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.xpReward,
    this.isCompleted = false,
    required this.icon,
  });

  MicroHabit copyWith({
    String? id,
    String? title,
    String? description,
    HabitCategory? category,
    int? xpReward,
    bool? isCompleted,
    IconData? icon,
  }) {
    return MicroHabit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      xpReward: xpReward ?? this.xpReward,
      isCompleted: isCompleted ?? this.isCompleted,
      icon: icon ?? this.icon,
    );
  }
}

class WeightEntry {
  final String id;
  final double weightKg;
  final DateTime recordedAt;
  final String? note;

  const WeightEntry({
    required this.id,
    required this.weightKg,
    required this.recordedAt,
    this.note,
  });
}
