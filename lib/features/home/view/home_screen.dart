import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stat_card.dart';
import '../../machines/view/personal_records_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Şimdilik sahte veriler; ileride gerçek veriyle değiştirilecek.
          const StatCard(
            icon: Icons.groups,
            title: 'Salon Doluluğu',
            value: '%45',
          ),
          const SizedBox(height: AppSpacing.md),
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
