import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../viewmodel/gym_occupancy_viewmodel.dart';

/// Ana Sayfa'daki canlı "Salon Doluluğu" kartı.
class GymOccupancyCard extends StatelessWidget {
  const GymOccupancyCard({super.key});

  static const _title = 'Salon Doluluğu';

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GymOccupancyViewModel>();
    final occupancy = vm.occupancy;

    if (vm.isLoading) {
      return const StatCard(
        icon: Icons.groups,
        title: _title,
        value: '',
        isLoading: true,
      );
    }

    // Hata varsa ve hiç veri gelmediyse hata göster; daha önce veri geldiyse
    // son bilinen değeri hata açıklamasıyla birlikte göster.
    if (occupancy == null) {
      return StatCard(
        icon: Icons.groups,
        title: _title,
        value: 'Doluluk bilgisi alınamadı',
        subtitle: vm.errorMessage,
      );
    }

    return StatCard(
      icon: Icons.groups,
      title: _title,
      value: '%${occupancy.percent}',
      subtitle: vm.errorMessage ?? 'Şu an ${occupancy.activeCount} kişi',
      isWarning: occupancy.isCrowded,
    );
  }
}
