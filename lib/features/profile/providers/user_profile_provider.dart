import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile_model.dart';

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier()
      : super(
          const UserProfile(
            id: 'guest-local-user-001',
            username: 'Aura Explorer',
            email: 'guest@fitnessaura.app',
            isGuest: true,
            level: 3,
            currentXp: 340,
            nextLevelXp: 500,
            auraRank: 'Ember Aura',
            totalWorkoutsLogged: 12,
            currentStreakDays: 5,
            badges: [
              AuraBadge(
                id: 'b1',
                name: 'First Spark',
                description: 'Logged first micro-habit',
                iconCode: '✨',
                isUnlocked: true,
              ),
              AuraBadge(
                id: 'b2',
                name: 'Iron Habit',
                description: 'Completed a 5-day habit streak',
                iconCode: '🔥',
                isUnlocked: true,
              ),
              AuraBadge(
                id: 'b3',
                name: 'Heavy Mover',
                description: 'Logged over 10,000 kg total volume',
                iconCode: '⚡',
                isUnlocked: true,
              ),
              AuraBadge(
                id: 'b4',
                name: 'Cloud Shield',
                description: 'Protect streak with verified account',
                iconCode: '🛡️',
                isUnlocked: false,
              ),
            ],
          ),
        );

  void upgradeGuestToCloud(String email, String username) {
    state = state.copyWith(
      isGuest: false,
      email: email,
      username: username,
      currentXp: state.currentXp + 100, // +100 XP Gamified Milestone Reward
      badges: state.badges.map((b) {
        if (b.id == 'b4') {
          return AuraBadge(
            id: b.id,
            name: b.name,
            description: b.description,
            iconCode: b.iconCode,
            isUnlocked: true,
            unlockedAt: DateTime.now(),
          );
        }
        return b;
      }).toList(),
    );
  }

  void addXp(int xp) {
    int newXp = state.currentXp + xp;
    int currentLevel = state.level;
    int nextXp = state.nextLevelXp;
    String currentRank = state.auraRank;

    if (newXp >= nextXp) {
      currentLevel += 1;
      newXp = newXp - nextXp;
      nextXp = (nextXp * 1.3).round();
      if (currentLevel >= 5) currentRank = 'Radiance Aura';
      if (currentLevel >= 10) currentRank = 'Supernova Aura';
    }

    state = state.copyWith(
      level: currentLevel,
      currentXp: newXp,
      nextLevelXp: nextXp,
      auraRank: currentRank,
    );
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});
