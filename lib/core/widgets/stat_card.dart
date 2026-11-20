import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Başlık + değer gösteren tekrar kullanılabilir bilgi kartı.
/// [subtitle] ve [onTap] isteğe bağlıdır; onTap verilirse kart tıklanabilir
/// olur ve sağda ok gösterilir. [compact] yan yana dizilen küçük kartlar
/// içindir (ikon üstte, dikey düzen).
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.onTap,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    final mutedColor = theme.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(color: mutedColor),
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
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
