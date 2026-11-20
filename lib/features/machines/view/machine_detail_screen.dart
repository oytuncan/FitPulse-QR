import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../model/machine.dart';

class MachineDetailScreen extends StatelessWidget {
  const MachineDetailScreen({super.key, required this.machine});

  final Machine machine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(machine.name)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              machine.name,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Doğru kullanım rehberi buraya gelecek',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
