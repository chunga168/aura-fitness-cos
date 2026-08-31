import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_aura/features/profile/providers/user_profile_provider.dart';

void main() {
  group('UserProfileNotifier Gamification & Cloud Upgrade Tests', () {
    test('Initial user profile starts in Guest mode at Level 3 Ember Aura', () {
      final notifier = UserProfileNotifier();
      expect(notifier.state.isGuest, true);
      expect(notifier.state.level, 3);
      expect(notifier.state.auraRank, 'Ember Aura');
      expect(notifier.state.badges.length, 4);
    });

    test('Claiming Cloud Shield upgrades guest to verified account and awards +100 XP', () {
      final notifier = UserProfileNotifier();
      final initialXp = notifier.state.currentXp;

      notifier.upgradeGuestToCloud('alex@example.com', 'Alex Rivers');

      expect(notifier.state.isGuest, false);
      expect(notifier.state.email, 'alex@example.com');
      expect(notifier.state.username, 'Alex Rivers');
      expect(notifier.state.currentXp, initialXp + 100);

      final cloudBadge = notifier.state.badges.firstWhere((b) => b.id == 'b4');
      expect(cloudBadge.isUnlocked, true);
    });

    test('Adding sufficient XP triggers Level Up and Rank Evolution', () {
      final notifier = UserProfileNotifier();
      notifier.addXp(600);
      expect(notifier.state.level >= 4, true);
    });
  });
}
