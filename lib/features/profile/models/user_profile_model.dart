class AuraBadge {
  final String id;
  final String name;
  final String description;
  final String iconCode;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const AuraBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconCode,
    this.isUnlocked = false,
    this.unlockedAt,
  });
}

class UserProfile {
  final String id;
  final String username;
  final String email;
  final bool isGuest;
  final int level;
  final int currentXp;
  final int nextLevelXp;
  final String auraRank; // Spark, Ember, Glow, Radiance, Supernova
  final int totalWorkoutsLogged;
  final int currentStreakDays;
  final List<AuraBadge> badges;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.isGuest,
    required this.level,
    required this.currentXp,
    required this.nextLevelXp,
    required this.auraRank,
    required this.totalWorkoutsLogged,
    required this.currentStreakDays,
    required this.badges,
  });

  double get xpProgress => currentXp / nextLevelXp;

  UserProfile copyWith({
    String? id,
    String? username,
    String? email,
    bool? isGuest,
    int? level,
    int? currentXp,
    int? nextLevelXp,
    String? auraRank,
    int? totalWorkoutsLogged,
    int? currentStreakDays,
    List<AuraBadge>? badges,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      isGuest: isGuest ?? this.isGuest,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      nextLevelXp: nextLevelXp ?? this.nextLevelXp,
      auraRank: auraRank ?? this.auraRank,
      totalWorkoutsLogged: totalWorkoutsLogged ?? this.totalWorkoutsLogged,
      currentStreakDays: currentStreakDays ?? this.currentStreakDays,
      badges: badges ?? this.badges,
    );
  }
}
