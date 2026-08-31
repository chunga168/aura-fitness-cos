import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/aura_colors.dart';
import '../../../core/theme/aura_glass.dart';

class SocialFeedItem {
  final String id;
  final String userName;
  final String avatarInitials;
  final String actionText;
  final String timeAgo;
  final int cheerCount;
  final bool hasCheered;

  const SocialFeedItem({
    required this.id,
    required this.userName,
    required this.avatarInitials,
    required this.actionText,
    required this.timeAgo,
    required this.cheerCount,
    this.hasCheered = false,
  });

  SocialFeedItem copyWith({
    int? cheerCount,
    bool? hasCheered,
  }) {
    return SocialFeedItem(
      id: id,
      userName: userName,
      avatarInitials: avatarInitials,
      actionText: actionText,
      timeAgo: timeAgo,
      cheerCount: cheerCount ?? this.cheerCount,
      hasCheered: hasCheered ?? this.hasCheered,
    );
  }
}

final socialFeedProvider =
    StateNotifierProvider<SocialFeedNotifier, List<SocialFeedItem>>((ref) {
  return SocialFeedNotifier();
});

class SocialFeedNotifier extends StateNotifier<List<SocialFeedItem>> {
  SocialFeedNotifier()
      : super([
          const SocialFeedItem(
            id: 'sf-1',
            userName: 'Elena Rostova',
            avatarInitials: 'ER',
            actionText: 'Completed Day 14 Streak: 100% Micro-Habits!',
            timeAgo: '12m ago',
            cheerCount: 8,
            hasCheered: false,
          ),
          const SocialFeedItem(
            id: 'sf-2',
            userName: 'Marcus Chen',
            avatarInitials: 'MC',
            actionText: 'Crushed Heavy Leg Day (12,400 kg Total Volume)',
            timeAgo: '1h ago',
            cheerCount: 15,
            hasCheered: true,
          ),
          const SocialFeedItem(
            id: 'sf-3',
            userName: 'Sarah Jenkins',
            avatarInitials: 'SJ',
            actionText: 'Unlocked Badge: Hydration Master 💧',
            timeAgo: '3h ago',
            cheerCount: 6,
            hasCheered: false,
          ),
        ]);

  void toggleCheer(String id) {
    state = state.map((item) {
      if (item.id == id) {
        final newHasCheered = !item.hasCheered;
        final newCount =
            newHasCheered ? item.cheerCount + 1 : item.cheerCount - 1;
        return item.copyWith(
          hasCheered: newHasCheered,
          cheerCount: newCount,
        );
      }
      return item;
    }).toList();
  }
}

class SocialScreen extends ConsumerWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedItems = ref.watch(socialFeedProvider);
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
                          'Community & Squad',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AuraColors.ghostWhite,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Cheer friends, co-op quests & leaderboards',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_add_alt_1_outlined,
                          color: AuraColors.neonTeal),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Active Squad Challenge Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AuraGlassCard(
                  padding: const EdgeInsets.all(20),
                  borderColor: AuraColors.electricViolet.withOpacity(0.5),
                  backgroundColor: AuraColors.midnightIndigo.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text('🤝', style: TextStyle(fontSize: 18)),
                              const SizedBox(width: 8),
                              Text(
                                'CO-OP SQUAD QUEST',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AuraColors.lavenderGlow,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '2 Days Left',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AuraColors.softAmber,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Weekend 25k Steps Tribe Challenge',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AuraColors.ghostWhite,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: 0.68,
                          minHeight: 8,
                          backgroundColor: AuraColors.surfaceContainerHighest,
                          valueColor: const AlwaysStoppedAnimation(AuraColors.neonTeal),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('17,000 / 25,000 steps reached',
                              style: theme.textTheme.bodySmall),
                          Text('+250 XP Reward',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AuraColors.lavenderGlow,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Friend Activity Feed Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
                child: Text(
                  'SQUAD ACTIVITY FEED',
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
                    final item = feedItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AuraGlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AuraColors.surfaceContainerHigh,
                                  child: Text(
                                    item.avatarInitials,
                                    style: const TextStyle(
                                      color: AuraColors.neonTeal,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.userName,
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AuraColors.ghostWhite,
                                        ),
                                      ),
                                      Text(item.timeAgo, style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: item.hasCheered
                                          ? AuraColors.neonTeal
                                          : AuraColors.outlineVariant,
                                    ),
                                    backgroundColor: item.hasCheered
                                        ? AuraColors.neonTeal.withOpacity(0.15)
                                        : Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    ref.read(socialFeedProvider.notifier).toggleCheer(item.id);
                                  },
                                  icon: Text(item.hasCheered ? '🔥' : '👏',
                                      style: const TextStyle(fontSize: 14)),
                                  label: Text(
                                    '${item.cheerCount}',
                                    style: TextStyle(
                                      color: item.hasCheered
                                          ? AuraColors.neonTeal
                                          : AuraColors.textSecondary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.actionText,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AuraColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: feedItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
