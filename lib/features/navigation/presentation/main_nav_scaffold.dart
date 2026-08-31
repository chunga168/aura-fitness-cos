import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/aura_colors.dart';
import '../../home/presentation/home_screen.dart';
import '../../activities/presentation/activities_screen.dart';
import '../../history/presentation/history_screen.dart';
import '../../social/presentation/social_screen.dart';
import '../../profile/presentation/profile_screen.dart';

final currentNavTabProvider = StateProvider<int>((ref) => 0);

class MainNavScaffold extends ConsumerWidget {
  const MainNavScaffold({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    ActivitiesScreen(),
    HistoryScreen(),
    SocialScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(currentNavTabProvider);

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentTab,
        children: _screens,
      ),
      bottomNavigationBar: _buildFloatingGlassNavBar(context, ref, currentTab),
    );
  }

  Widget _buildFloatingGlassNavBar(
      BuildContext context, WidgetRef ref, int currentTab) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AuraColors.surfaceContainerLow.withOpacity(0.75),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: AuraColors.neonTeal.withOpacity(0.2),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AuraColors.midnightIndigo.withOpacity(0.6),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    index: 0,
                    label: 'Home',
                    activeIcon: Icons.home_rounded,
                    inactiveIcon: Icons.home_outlined,
                    isSelected: currentTab == 0,
                    onTap: () => ref.read(currentNavTabProvider.notifier).state = 0,
                  ),
                  _navItem(
                    index: 1,
                    label: 'Activities',
                    activeIcon: Icons.fitness_center_rounded,
                    inactiveIcon: Icons.fitness_center_outlined,
                    isSelected: currentTab == 1,
                    onTap: () => ref.read(currentNavTabProvider.notifier).state = 1,
                  ),
                  _navItem(
                    index: 2,
                    label: 'History',
                    activeIcon: Icons.calendar_month_rounded,
                    inactiveIcon: Icons.calendar_month_outlined,
                    isSelected: currentTab == 2,
                    onTap: () => ref.read(currentNavTabProvider.notifier).state = 2,
                  ),
                  _navItem(
                    index: 3,
                    label: 'Social',
                    activeIcon: Icons.people_alt_rounded,
                    inactiveIcon: Icons.people_alt_outlined,
                    isSelected: currentTab == 3,
                    onTap: () => ref.read(currentNavTabProvider.notifier).state = 3,
                  ),
                  _navItem(
                    index: 4,
                    label: 'Profile',
                    activeIcon: Icons.person_rounded,
                    inactiveIcon: Icons.person_outline_rounded,
                    isSelected: currentTab == 4,
                    onTap: () => ref.read(currentNavTabProvider.notifier).state = 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String label,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AuraColors.neonTeal.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              size: 22,
              color: isSelected ? AuraColors.neonTeal : AuraColors.textMuted,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AuraColors.ghostWhite : AuraColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
