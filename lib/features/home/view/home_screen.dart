import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stat_card.dart';
import '../../gate_entry/view/gym_occupancy_card.dart';
import '../../machines/view/personal_records_screen.dart';
import '../../nutrition/viewmodel/nutrition_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenNutrition});

  /// Beslenme sekmesine geçiş (MainShell sağlar).
  final VoidCallback onOpenNutrition;

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionViewModel>();
    final calories = nutrition.profile?.result.calories;

    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Firestore'dan canlı doluluk.
          const GymOccupancyCard(),
          const SizedBox(height: AppSpacing.md),
          // Şimdilik sahte veriler; ileride gerçek veriyle değiştirilecek.
          const StatCard(
            icon: Icons.flag,
            title: 'Haftalık Hedef',
            value: '2/4 gün',
          ),
          const SizedBox(height: AppSpacing.md),
          const StatCard(
            icon: Icons.stars,
            title: 'Puanım',
            value: '120',
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
