import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Başlık + değer gösteren tekrar kullanılabilir bilgi kartı.
/// [subtitle] ve [onTap] isteğe bağlıdır; onTap verilirse kart tıklanabilir
/// olur ve sağda ok gösterilir. [compact] yan yana dizilen küçük kartlar
/// içindir (ikon üstte, dikey düzen). [isLoading] değerin yerine yükleniyor
/// göstergesi koyar; [isWarning] kartı uyarı renklerine boyar.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.onTap,
    this.compact = false,
    this.isLoading = false,
    this.isWarning = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool compact;
  final bool isLoading;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isWarning ? Theme.of(context).colorScheme.errorContainer : null,
      // Dokunma efekti yuvarlak köşelerin dışına taşmasın.
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: compact ? _buildCompact(context) : _buildRegular(context),
      ),
    );
  }

  Widget _buildRegular(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final mutedColor = isWarning
        ? scheme.onErrorContainer
        : scheme.onSurfaceVariant;
    final iconColor = isWarning ? scheme.onErrorContainer : scheme.primary;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, size: 32, color: iconColor),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: mutedColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                  )
                else
                  Text(
                    value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isWarning ? scheme.onErrorContainer : null,
                    ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onTap != null) Icon(Icons.chevron_right, color: mutedColor),
        ],
      ),
    );
  }

  Widget _buildCompact(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm + AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.primary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
