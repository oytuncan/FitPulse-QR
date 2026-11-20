import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/stat_card.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import '../model/machine.dart';
import '../repository/pr_repository.dart';
import '../viewmodel/machine_detail_viewmodel.dart';

class MachineDetailScreen extends StatelessWidget {
  const MachineDetailScreen({super.key, required this.machine});

  final Machine machine;

  @override
  Widget build(BuildContext context) {
    // Ekrana özel ViewModel; ekran kapanınca o da kapanır.
    return ChangeNotifierProvider(
      create: (context) => MachineDetailViewModel(
        repository: context.read<PrRepository>(),
        userId: context.read<AuthViewModel>().currentUserId!,
        machine: machine,
      )..load(),
      child: const _MachineDetailView(),
    );
  }
}

class _MachineDetailView extends StatefulWidget {
  const _MachineDetailView();

  @override
  State<_MachineDetailView> createState() => _MachineDetailViewState();
}

class _MachineDetailViewState extends State<_MachineDetailView> {
  final _weightCtrl = TextEditingController();

  @override
  void dispose() {
    _weightCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final vm = context.read<MachineDetailViewModel>();
    final message = await vm.save(_weightCtrl.text);
    if (!mounted || message == null) return;

    if (vm.inputError == null) _weightCtrl.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MachineDetailViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(vm.machine.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            vm.machine.name,
            style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.md),
          StatCard(
            icon: Icons.emoji_events,
            title: 'Kişisel Rekorum',
            value: vm.isLoading
                ? '...'
                : vm.bestWeight == null
                    ? 'Henüz kayıt yok'
                    : formatKg(vm.bestWeight!),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Kilo girişi
          TextField(
            controller: _weightCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _save(),
            decoration: InputDecoration(
              labelText: 'Kilo (kg)',
              hintText: 'örn. 82,5',
              errorText: vm.inputError,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: vm.isSaving ? null : _save,
              child: vm.isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Kaydet'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Geçmiş kayıtlar (yeniden eskiye)
          Text('Geçmiş Kayıtlar', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          if (vm.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (vm.history.isEmpty)
            Text(
              'Henüz kayıt yok',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            )
          else
            for (final entry in vm.history)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.fitness_center),
                title: Text(formatKg(entry.weightKg)),
                subtitle: Text(formatDateTime(entry.createdAt)),
              ),
        ],
      ),
    );
  }
}
