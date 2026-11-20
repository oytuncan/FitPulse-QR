import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/stat_card.dart';
import '../model/nutrition_profile.dart';
import '../viewmodel/nutrition_viewmodel.dart';

/// Beslenme sekmesi: profil yoksa form, varsa günlük hedefler.
/// ViewModel MainShell'de sağlanır (Ana Sayfa kartı da aynısını kullanır).
class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  /// Formu kayıtlı değerlerle doldurup düzenleme moduna geçer.
  void _startEditing(NutritionViewModel vm) {
    final input = vm.profile?.input;
    if (input != null) {
      _ageCtrl.text = input.age.toString();
      _heightCtrl.text = formatDecimal(input.heightCm);
      _weightCtrl.text = formatDecimal(input.weightKg);
    }
    vm.startEditing();
  }

  Future<void> _submit(NutritionViewModel vm) async {
    FocusScope.of(context).unfocus();
    await vm.calculateAndSave(
      age: _ageCtrl.text,
      height: _heightCtrl.text,
      weight: _weightCtrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NutritionViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Beslenme')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                if (vm.showForm) ..._buildForm(vm) else ..._buildResults(vm),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Bu değerler tahmindir, tıbbi tavsiye değildir.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildForm(NutritionViewModel vm) {
    const gap = SizedBox(height: AppSpacing.md);

    InputDecoration deco(String label, String? error, {String? suffix}) =>
        InputDecoration(
          labelText: label,
          errorText: error,
          suffixText: suffix,
          border: const OutlineInputBorder(),
        );

    return [
      Text(
        'Günlük kalori ve makro hedefini hesaplamak için bilgilerini gir.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      gap,
      DropdownButtonFormField<Gender>(
        initialValue: vm.gender,
        decoration: deco('Cinsiyet', vm.genderError),
        items: [
          for (final g in Gender.values)
            DropdownMenuItem(value: g, child: Text(g.label)),
        ],
        onChanged: vm.setGender,
      ),
      gap,
      TextField(
        controller: _ageCtrl,
        keyboardType: TextInputType.number,
        decoration: deco('Yaş', vm.ageError),
      ),
      gap,
      TextField(
        controller: _heightCtrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: deco('Boy', vm.heightError, suffix: 'cm'),
      ),
      gap,
      TextField(
        controller: _weightCtrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: deco('Kilo', vm.weightError, suffix: 'kg'),
      ),
      gap,
      DropdownButtonFormField<ActivityLevel>(
        initialValue: vm.activityLevel,
        decoration: deco('Aktivite seviyesi', vm.activityError),
        items: [
          for (final a in ActivityLevel.values)
            DropdownMenuItem(value: a, child: Text(a.label)),
        ],
        onChanged: vm.setActivityLevel,
      ),
      gap,
      DropdownButtonFormField<Goal>(
        initialValue: vm.goal,
        decoration: deco('Hedef', vm.goalError),
        items: [
          for (final g in Goal.values)
            DropdownMenuItem(value: g, child: Text(g.label)),
        ],
        onChanged: vm.setGoal,
      ),
      if (vm.saveError != null) ...[
        gap,
        Text(vm.saveError!, style: const TextStyle(color: Colors.red)),
      ],
      const SizedBox(height: AppSpacing.lg),
      SizedBox(
        height: 48,
        child: FilledButton(
          onPressed: vm.isSaving ? null : () => _submit(vm),
          child: vm.isSaving
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Hesapla ve Kaydet'),
        ),
      ),
      // Kayıtlı profil varken düzenlemeden vazgeçilebilir.
      if (vm.profile != null)
        TextButton(
          onPressed: vm.isSaving ? null : vm.cancelEditing,
          child: const Text('Vazgeç'),
        ),
    ];
  }

  List<Widget> _buildResults(NutritionViewModel vm) {
    final theme = Theme.of(context);
    final input = vm.profile!.input;
    final result = vm.profile!.result;

    return [
      StatCard(
        icon: Icons.local_fire_department,
        title: 'Günlük kalori hedefin',
        value: '${result.calories} kcal',
        subtitle: input.goal.label,
      ),
      const SizedBox(height: AppSpacing.sm),
      // Üç makro kartı yan yana, eşit yükseklikte.
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StatCard(
                compact: true,
                icon: Icons.egg_alt,
                title: 'Protein',
                value: '${result.proteinG} g',
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatCard(
                compact: true,
                icon: Icons.bakery_dining,
                title: 'Karbonhidrat',
                value: '${result.carbsG} g',
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatCard(
                compact: true,
                icon: Icons.water_drop,
                title: 'Yağ',
                value: '${result.fatG} g',
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      // Hesabın dayandığı bilgilerin kısa özeti
      Text(
        '${input.gender.label}, ${input.age} yaş, '
        '${formatDecimal(input.heightCm)} cm, ${formatKg(input.weightKg)} · '
        '${input.activityLevel.label}',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
      const SizedBox(height: AppSpacing.md),
      OutlinedButton.icon(
        onPressed: () => _startEditing(vm),
        icon: const Icon(Icons.edit),
        label: const Text('Bilgileri düzenle'),
      ),
    ];
  }
}
