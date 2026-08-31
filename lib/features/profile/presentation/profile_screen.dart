import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/aura_colors.dart';
import '../../../core/theme/aura_glass.dart';
import '../../../core/theme/aura_theme.dart';
import '../../../core/theme/aura_typography.dart';
import '../providers/user_profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final themeState = ref.watch(auraThemeProvider);
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
                          'Profile & Aura Rank',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AuraColors.ghostWhite,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Progression, achievements & appearance',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined,
                          color: AuraColors.textSecondary),
                      onPressed: () {
                        _showThemeStudioModal(context, ref);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Profile Overview & Level Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AuraGlassCard(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AuraColors.peakAuraGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AuraColors.neonTeal.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text('🌟', style: TextStyle(fontSize: 28)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      userProfile.username,
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AuraColors.ghostWhite,
                                      ),
                                    ),
                                    if (userProfile.isGuest) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AuraColors.softAmber.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'Guest',
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: AuraColors.softAmber,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Level ${userProfile.level} • ${userProfile.auraRank}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AuraColors.lavenderGlow,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // XP Progress bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('AURA ENERGY (XP)',
                              style: theme.textTheme.labelSmall?.copyWith(
                                letterSpacing: 1.0,
                                color: AuraColors.textMuted,
                                fontWeight: FontWeight.w700,
                              )),
                          Text(
                            '${userProfile.currentXp} / ${userProfile.nextLevelXp} XP',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AuraColors.neonTeal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: userProfile.xpProgress.clamp(0.0, 1.0),
                          minHeight: 10,
                          backgroundColor: AuraColors.surfaceContainerHighest,
                          valueColor:
                              const AlwaysStoppedAnimation(AuraColors.neonTeal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Cloud Shield Guest Upgrade Quest
            if (userProfile.isGuest)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: AuraGlassCard(
                    padding: const EdgeInsets.all(20),
                    borderColor: AuraColors.neonTeal,
                    backgroundColor: AuraColors.midnightIndigo.withOpacity(0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('🛡️', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Protect Your Aura in Cloud (+100 XP)',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: AuraColors.ghostWhite,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Link an account (Email, Google or Apple) to ensure your streaks, workout history & weight data are backed up.',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 14),
                        AuraGradientButton(
                          text: 'Create Account & Claim +100 XP',
                          height: 44,
                          borderRadius: 16,
                          onPressed: () {
                            _showCloudUpgradeDialog(context, ref);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Badges & Achievements
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
                child: Text(
                  'UNLOCKED AURA BADGES',
                  style: theme.textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.2,
                    color: AuraColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final badge = userProfile.badges[index];
                    return AuraGlassCard(
                      padding: const EdgeInsets.all(14),
                      borderColor: badge.isUnlocked
                          ? AuraColors.electricViolet.withOpacity(0.4)
                          : AuraColors.outlineVariant.withOpacity(0.2),
                      backgroundColor: badge.isUnlocked
                          ? AuraColors.surfaceContainer.withOpacity(0.6)
                          : AuraColors.surfaceContainerLowest.withOpacity(0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(badge.iconCode, style: const TextStyle(fontSize: 22)),
                              if (badge.isUnlocked)
                                const Icon(Icons.check_circle,
                                    size: 16, color: AuraColors.neonTeal),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            badge.name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: badge.isUnlocked
                                  ? AuraColors.ghostWhite
                                  : AuraColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            badge.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: userProfile.badges.length,
                ),
              ),
            ),

            // Theme & Customization Studio Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                child: AuraGlassCard(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Icon(Icons.palette_outlined,
                          color: AuraColors.neonTeal, size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aura Appearance Studio',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AuraColors.ghostWhite,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Palette: ${themeState.palette.displayName} • Font: ${themeState.fontFamily.displayName}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AuraColors.neonTeal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => _showThemeStudioModal(context, ref),
                        child: const Text('Customize',
                            style: TextStyle(color: AuraColors.neonTeal)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCloudUpgradeDialog(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AuraColors.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Claim Cloud Shield (+100 XP)',
              style: TextStyle(color: AuraColors.ghostWhite)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: TextStyle(color: AuraColors.textSecondary),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: AuraColors.textSecondary),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AuraColors.textMuted)),
            ),
            AuraGradientButton(
              text: 'Save & Sync',
              height: 40,
              borderRadius: 20,
              onPressed: () {
                if (emailController.text.isNotEmpty) {
                  ref.read(userProfileProvider.notifier).upgradeGuestToCloud(
                        emailController.text,
                        nameController.text.isNotEmpty
                            ? nameController.text
                            : 'Aura Champion',
                      );
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showThemeStudioModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AuraColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Consumer(builder: (context, ref, _) {
          final themeState = ref.watch(auraThemeProvider);
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AuraColors.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Aura Appearance Studio',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AuraColors.ghostWhite,
                            fontWeight: FontWeight.w700,
                          )),
                  const SizedBox(height: 6),
                  Text('Customize typography and vitality color accents in real-time.',
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 20),
                  Text('COLOR ACCENT PALETTE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AuraColors.neonTeal,
                            fontWeight: FontWeight.w700,
                          )),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: AuraColorPalette.values.map((p) {
                      final isSelected = themeState.palette == p;
                      return ChoiceChip(
                        label: Text(p.displayName),
                        selected: isSelected,
                        selectedColor: p.primaryAccent.withOpacity(0.3),
                        labelStyle: TextStyle(
                          color: isSelected ? p.primaryAccent : AuraColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        side: BorderSide(
                          color: isSelected ? p.primaryAccent : Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        onSelected: (_) =>
                            ref.read(auraThemeProvider.notifier).setPalette(p),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text('TYPOGRAPHY SCALE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AuraColors.neonTeal,
                            fontWeight: FontWeight.w700,
                          )),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: AuraFontFamily.values.map((f) {
                      final isSelected = themeState.fontFamily == f;
                      return ChoiceChip(
                        label: Text(f.displayName),
                        selected: isSelected,
                        selectedColor: AuraColors.electricViolet.withOpacity(0.3),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AuraColors.lavenderGlow
                              : AuraColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? AuraColors.lavenderGlow
                              : Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        onSelected: (_) =>
                            ref.read(auraThemeProvider.notifier).setFontFamily(f),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
