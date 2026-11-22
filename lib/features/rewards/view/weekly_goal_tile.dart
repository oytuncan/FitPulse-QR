import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_stats.dart';
import '../viewmodel/user_stats_viewmodel.dart';

/// Profil'deki haftalık hedef ayarı (haftada 1-7 gün).
class WeeklyGoalTile extends StatelessWidget {
  const WeeklyGoalTile({super.key});

  Future<void> _onChanged(BuildContext context, int? days) async {
    if (days == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final error = await context.read<UserStatsViewModel>().setWeeklyGoal(days);
    if (error != null) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserStatsViewModel>();

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.flag),
      title: const Text('Haftalık hedef'),
      subtitle: Text(vm.errorMessage ?? 'Haftada kaç gün salona geleceksin?'),
      trailing: DropdownButton<int>(
        value: vm.weeklyGoalDays,
        // Kullanıcı bilgisi yüklenene kadar değiştirilemez.
        onChanged: vm.stats == null ? null : (d) => _onChanged(context, d),
        items: [
          for (
            var d = UserStats.minWeeklyGoalDays;
            d <= UserStats.maxWeeklyGoalDays;
            d++
          )
            DropdownMenuItem(value: d, child: Text('$d gün')),
        ],
      ),
    );
  }
}
