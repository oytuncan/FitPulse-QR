import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Başlık + değer gösteren tekrar kullanılabilir bilgi kartı.
/// [subtitle] ve [onTap] isteğe bağlıdır; onTap verilirse kart tıklanabilir
/// olur ve sağda ok gösterilir.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = theme.colorScheme.onSurfaceVariant;

    return Card(
      // Dokunma efekti yuvarlak köşelerin dışına taşmasın.
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
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
                      style:
                          theme.textTheme.bodyMedium?.copyWith(color: mutedColor),
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
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: mutedColor),
                      ),
                    ],
                  ],
                ),
              ),
              if (onTap != null) Icon(Icons.chevron_right, color: mutedColor),
            ],
          ),
        ),
      ),
    );
  }
}
