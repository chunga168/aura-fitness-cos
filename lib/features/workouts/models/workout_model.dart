enum MuscleGroup {
  chest,
  lats,
  delts,
  biceps,
  triceps,
  core,
  legs,
}

extension MuscleGroupExtension on MuscleGroup {
  String get displayName {
    switch (this) {
      case MuscleGroup.chest:
        return 'Chest';
      case MuscleGroup.lats:
        return 'Lats & Back';
      case MuscleGroup.delts:
        return 'Delts & Shoulders';
      case MuscleGroup.biceps:
        return 'Biceps';
      case MuscleGroup.triceps:
        return 'Triceps';
      case MuscleGroup.core:
        return 'Core & Abs';
      case MuscleGroup.legs:
        return 'Quads & Glutes';
    }
  }
}

class ExerciseSet {
  final int setNumber;
  final double weightKg;
  final int reps;
  final double? rpe;
  final bool isCompleted;

  const ExerciseSet({
    required this.setNumber,
    required this.weightKg,
    required this.reps,
    this.rpe,
    this.isCompleted = false,
  });

  ExerciseSet copyWith({
    int? setNumber,
    double? weightKg,
    int? reps,
    double? rpe,
    bool? isCompleted,
  }) {
    return ExerciseSet(
      setNumber: setNumber ?? this.setNumber,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      rpe: rpe ?? this.rpe,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final MuscleGroup targetMuscle;
  final List<ExerciseSet> sets;
  final String? personalBest;

  const Exercise({
    required this.id,
    required this.name,
    required this.targetMuscle,
    required this.sets,
    this.personalBest,
  });

  double get totalVolumeKg {
    return sets
        .where((s) => s.isCompleted)
        .fold(0.0, (sum, s) => sum + (s.weightKg * s.reps));
  }
}

class WorkoutSession {
  final String id;
  final String title;
  final String location; // Gym, Home, Outdoor
  final DateTime date;
  final int durationMinutes;
  final List<Exercise> exercises;
  final int xpEarned;
  final bool isCompleted;

  const WorkoutSession({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.durationMinutes,
    required this.exercises,
    required this.xpEarned,
    this.isCompleted = true,
  });

  double get totalVolumeKg {
    return exercises.fold(0.0, (sum, ex) => sum + ex.totalVolumeKg);
  }
}
