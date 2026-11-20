import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      // Şimdilik sahte veriler; ileride gerçek veriyle değiştirilecek.
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          StatCard(
            icon: Icons.groups,
            title: 'Salon Doluluğu',
            value: '%45',
          ),
          SizedBox(height: AppSpacing.md),
          StatCard(
            icon: Icons.flag,
            title: 'Haftalık Hedef',
            value: '2/4 gün',
          ),
          SizedBox(height: AppSpacing.md),
          StatCard(
            icon: Icons.stars,
            title: 'Puanım',
            value: '120',
          ),
        ],
      ),
    );
  }
}
