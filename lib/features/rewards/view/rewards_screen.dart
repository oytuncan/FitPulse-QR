import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/stat_card.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import '../model/redemption.dart';
import '../model/reward.dart';
import '../repository/rewards_repository.dart';
import '../viewmodel/store_viewmodel.dart';
import '../viewmodel/user_stats_viewmodel.dart';

/// Mağaza sekmesi: puan, ödüller ve geçmiş talepler.
class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StoreViewModel(
        repository: context.read<RewardsRepository>(),
        userId: context.read<AuthViewModel>().currentUserId!,
      ),
      child: const _StoreView(),
    );
  }
}

class _StoreView extends StatelessWidget {
  const _StoreView();

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<UserStatsViewModel>();
    final store = context.watch<StoreViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mağaza')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          StatCard(
            icon: Icons.stars,
            title: 'Puanım',
            value: '${stats.points}',
            subtitle: stats.errorMessage,
            isLoading: stats.isLoading,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SectionTitle('Ödüller'),
          ..._buildRewards(context, stats, store),
          const SizedBox(height: AppSpacing.lg),
          const _SectionTitle('Taleplerim'),
          ..._buildRedemptions(store),
        ],
      ),
    );
  }

  List<Widget> _buildRewards(
    BuildContext context,
    UserStatsViewModel stats,
    StoreViewModel store,
  ) {
    final rewards = store.rewards;
    if (rewards == null) {
      return [_StatusText(store.rewardsError, isLoading: true)];
    }
    if (rewards.isEmpty) {
      return const [_StatusText('Şu an mağazada ödül yok.')];
    }
    return [
      if (store.rewardsError != null) _StatusText(store.rewardsError),
      for (final reward in rewards)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _RewardCard(
            reward: reward,
            // Puan henüz yüklenmediyse eksik puanı bilinmiyor sayılır.
            missingPoints: stats.stats == null
                ? null
                : reward.costPoints - stats.points,
            isRedeeming: store.redeemingId == reward.id,
            enabled: !store.isRedeeming,
            onRedeem: () => _confirmAndRedeem(context, reward),
          ),
        ),
    ];
  }

  List<Widget> _buildRedemptions(StoreViewModel store) {
    final redemptions = store.redemptions;
    if (redemptions == null) {
      return [_StatusText(store.redemptionsError, isLoading: true)];
    }
    if (redemptions.isEmpty) {
      return const [_StatusText('Henüz bir talebin yok.')];
    }
    return [
      if (store.redemptionsError != null) _StatusText(store.redemptionsError),
      for (final r in redemptions)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _RedemptionTile(redemption: r),
        ),
    ];
  }

  /// Onay penceresi; onaylanırsa talep transaction'ı çalışır.
  Future<void> _confirmAndRedeem(BuildContext context, Reward reward) async {
    final store = context.read<StoreViewModel>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Talebi onayla'),
        content: Text(
          '${reward.name} için ${reward.costPoints} puan harcanacak, '
          'onaylıyor musun?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Onayla'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final message = await store.redeem(reward);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message.text)));
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

/// Yükleniyor göstergesi, hata ya da boş liste mesajı.
class _StatusText extends StatelessWidget {
  const _StatusText(this.message, {this.isLoading = false});

  final String? message;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // Hata yokken yükleniyorsa gösterge, aksi halde mesaj.
    if (isLoading && message == null) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(
        message ?? '',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.reward,
    required this.missingPoints,
    required this.isRedeeming,
    required this.enabled,
    required this.onRedeem,
  });

  final Reward reward;

  /// Eksik puan; 0 ya da altıysa puan yetiyor, null ise henüz bilinmiyor.
  final int? missingPoints;
  final bool isRedeeming;
  final bool enabled;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    final missing = missingPoints;
    final canAfford = missing != null && missing <= 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(reward.name, style: theme.textTheme.titleMedium),
                ),
                Text(
                  '${reward.costPoints} puan',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (reward.description.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                reward.description,
                style: theme.textTheme.bodyMedium?.copyWith(color: muted),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: missing != null && missing > 0
                      ? Text(
                          '$missing puan daha lazım',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: muted,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                FilledButton(
                  onPressed: canAfford && enabled ? onRedeem : null,
                  child: isRedeeming
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Talep et'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RedemptionTile extends StatelessWidget {
  const _RedemptionTile({required this.redemption});

  final Redemption redemption;

  @override
  Widget build(BuildContext context) {
    final createdAt = redemption.createdAt;

    return Card(
      child: ListTile(
        leading: const Icon(Icons.card_giftcard),
        title: Text(redemption.rewardName),
        subtitle: Text(
          '${redemption.costPoints} puan · '
          '${createdAt == null ? 'az önce' : formatDateTime(createdAt)}',
        ),
        trailing: Chip(label: Text(redemption.statusLabel)),
      ),
    );
  }
}
