import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_model.dart';

class WorkoutState {
  final List<WorkoutSession> pastWorkouts;
  final WorkoutSession? activeWorkout;
  final MuscleGroup? selectedFilter;

  const WorkoutState({
    required this.pastWorkouts,
    this.activeWorkout,
    this.selectedFilter,
  });

  WorkoutState copyWith({
    List<WorkoutSession>? pastWorkouts,
    WorkoutSession? activeWorkout,
    MuscleGroup? selectedFilter,
    bool clearActive = false,
  }) {
    return WorkoutState(
      pastWorkouts: pastWorkouts ?? this.pastWorkouts,
      activeWorkout: clearActive ? null : (activeWorkout ?? this.activeWorkout),
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class WorkoutNotifier extends StateNotifier<WorkoutState> {
  WorkoutNotifier()
      : super(
          WorkoutState(
            pastWorkouts: [
              WorkoutSession(
                id: 'ws-01',
                title: 'Upper Body Hypertrophy',
                location: 'Main Gym',
                date: DateTime.now().subtract(const Duration(days: 1)),
                durationMinutes: 52,
                xpEarned: 120,
                exercises: [
                  const Exercise(
                    id: 'ex-01',
                    name: 'Barbell Bench Press',
                    targetMuscle: MuscleGroup.chest,
                    personalBest: '90 kg x 6 reps',
                    sets: [
                      ExerciseSet(setNumber: 1, weightKg: 70, reps: 10, isCompleted: true),
                      ExerciseSet(setNumber: 2, weightKg: 80, reps: 8, isCompleted: true),
                      ExerciseSet(setNumber: 3, weightKg: 85, reps: 6, isCompleted: true),
                    ],
                  ),
                  const Exercise(
                    id: 'ex-02',
                    name: 'Lat Pulldown',
                    targetMuscle: MuscleGroup.lats,
                    personalBest: '75 kg x 10 reps',
                    sets: [
                      ExerciseSet(setNumber: 1, weightKg: 60, reps: 12, isCompleted: true),
                      ExerciseSet(setNumber: 2, weightKg: 65, reps: 10, isCompleted: true),
                      ExerciseSet(setNumber: 3, weightKg: 70, reps: 8, isCompleted: true),
                    ],
                  ),
                ],
              ),
              WorkoutSession(
                id: 'ws-02',
                title: 'Legs & Core Power',
                location: 'Home Gym',
                date: DateTime.now().subtract(const Duration(days: 3)),
                durationMinutes: 45,
                xpEarned: 110,
                exercises: [
                  const Exercise(
                    id: 'ex-03',
                    name: 'Barbell Back Squat',
                    targetMuscle: MuscleGroup.legs,
                    personalBest: '110 kg x 5 reps',
                    sets: [
                      ExerciseSet(setNumber: 1, weightKg: 80, reps: 10, isCompleted: true),
                      ExerciseSet(setNumber: 2, weightKg: 95, reps: 8, isCompleted: true),
                      ExerciseSet(setNumber: 3, weightKg: 105, reps: 5, isCompleted: true),
                    ],
                  ),
                ],
              ),
            ],
            activeWorkout: null,
          ),
        );

  void startWorkout(String title, String location) {
    state = state.copyWith(
      activeWorkout: WorkoutSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        location: location,
        date: DateTime.now(),
        durationMinutes: 0,
        xpEarned: 100,
        isCompleted: false,
        exercises: const [
          Exercise(
            id: 'ex-live-01',
            name: 'Incline Dumbbell Press',
            targetMuscle: MuscleGroup.chest,
            personalBest: '32 kg x 8 reps',
            sets: [
              ExerciseSet(setNumber: 1, weightKg: 26, reps: 10, isCompleted: true),
              ExerciseSet(setNumber: 2, weightKg: 28, reps: 8, isCompleted: true),
              ExerciseSet(setNumber: 3, weightKg: 30, reps: 6, isCompleted: false),
            ],
          ),
        ],
      ),
    );
  }

  void completeActiveWorkout() {
    if (state.activeWorkout != null) {
      final finished = WorkoutSession(
        id: state.activeWorkout!.id,
        title: state.activeWorkout!.title,
        location: state.activeWorkout!.location,
        date: state.activeWorkout!.date,
        durationMinutes: 48,
        xpEarned: 135,
        exercises: state.activeWorkout!.exercises,
        isCompleted: true,
      );
      state = state.copyWith(
        pastWorkouts: [finished, ...state.pastWorkouts],
        clearActive: true,
      );
    }
  }

  void cancelActiveWorkout() {
    state = state.copyWith(clearActive: true);
  }

  void setFilter(MuscleGroup? group) {
    state = state.copyWith(selectedFilter: group);
  }
}

final workoutProvider = StateNotifierProvider<WorkoutNotifier, WorkoutState>((ref) {
  return WorkoutNotifier();
});
