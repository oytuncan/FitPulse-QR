import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/stat_card.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import '../model/machine.dart';
import '../repository/pr_repository.dart';
import '../viewmodel/personal_records_viewmodel.dart';
import 'machine_detail_screen.dart';

/// Kullanıcının her makinedeki en yüksek kilosunu listeler.
class PersonalRecordsScreen extends StatelessWidget {
  const PersonalRecordsScreen({super.key});

  /// Ana Sayfa ve Profil'den bu ekranı açmak için.
  static void open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PersonalRecordsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonalRecordsViewModel(
        repository: context.read<PrRepository>(),
        userId: context.read<AuthViewModel>().currentUserId!,
      )..load(),
      child: const _PersonalRecordsView(),
    );
  }
}

class _PersonalRecordsView extends StatelessWidget {
  const _PersonalRecordsView();

  /// Detaya git; geri dönünce listeyi yenile (yeni rekor eklenmiş olabilir).
  Future<void> _openMachine(BuildContext context, Machine machine) async {
    final vm = context.read<PersonalRecordsViewModel>();
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MachineDetailScreen(machine: machine)),
    );
    await vm.load();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PersonalRecordsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Rekorlarım')),
      body: _buildBody(context, vm),
    );
  }

  Widget _buildBody(BuildContext context, PersonalRecordsViewModel vm) {
    final theme = Theme.of(context);

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final message = vm.errorMessage ??
        (vm.records.isEmpty
            ? 'Henüz rekor kaydın yok. Tara sekmesinden bir makine QR kodu '
                'okutarak başla.'
            : null);
    if (message != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events_outlined,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      // İlk satır özet, gerisi makine kartları.
      itemCount: vm.records.length + 1,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, i) {
        if (i == 0) {
          return Text(
            '${vm.records.length} makinede rekorun var',
            style: theme.textTheme.titleMedium,
          );
        }
        final pr = vm.records[i - 1];
        return StatCard(
          icon: Icons.emoji_events,
          title: pr.machine.name,
          value: formatKg(pr.weightKg),
          subtitle: formatDateTime(pr.achievedAt),
          onTap: () => _openMachine(context, pr.machine),
        );
      },
    );
  }
}
