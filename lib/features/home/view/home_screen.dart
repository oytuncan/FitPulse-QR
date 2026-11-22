import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stat_card.dart';
import '../../gate_entry/view/gym_occupancy_card.dart';
import '../../machines/view/personal_records_screen.dart';
import '../../nutrition/viewmodel/nutrition_viewmodel.dart';
import '../../rewards/viewmodel/user_stats_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenNutrition});

  /// Beslenme sekmesine geçiş (MainShell sağlar).
  final VoidCallback onOpenNutrition;

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionViewModel>();
    final stats = context.watch<UserStatsViewModel>();
    final calories = nutrition.profile?.result.calories;

    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Firestore'dan canlı doluluk.
          const GymOccupancyCard(),
          const SizedBox(height: AppSpacing.md),
          // users/{uid} belgesinden canlı; belge yoksa 0 puan, 0 gün.
          StatCard(
            icon: Icons.flag,
            title: 'Haftalık Hedef',
            value: '${stats.daysThisWeek}/${stats.weeklyGoalDays} gün',
            subtitle: stats.errorMessage,
            isLoading: stats.isLoading,
          ),
          const SizedBox(height: AppSpacing.md),
          StatCard(
            icon: Icons.stars,
            title: 'Puanım',
            value: '${stats.points}',
            subtitle: stats.errorMessage,
            isLoading: stats.isLoading,
          ),
          const SizedBox(height: AppSpacing.md),
          // Beslenme profili varsa günlük kalori, yoksa yönlendirme.
          StatCard(
            icon: Icons.restaurant,
            title: 'Günlük hedefim',
            value: nutrition.isLoading
                ? '...'
                : calories == null
                    ? 'Beslenme hedefini belirle'
                    : '$calories kcal',
            onTap: onOpenNutrition,
          ),
          const SizedBox(height: AppSpacing.md),
          StatCard(
            icon: Icons.emoji_events,
            title: 'Makinelerdeki en yüksek kilolarım',
            value: 'Rekorlarım',
            onTap: () => PersonalRecordsScreen.open(context),
          ),
        ],
      ),
    );
  }
}
