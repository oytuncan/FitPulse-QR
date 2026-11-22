import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import '../../machines/view/personal_records_screen.dart';
import '../../rewards/view/weekly_goal_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.emoji_events),
              title: const Text('Rekorlarım'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => PersonalRecordsScreen.open(context),
            ),
            const WeeklyGoalTile(),
            const Spacer(),
            // Çıkış yapınca main.dart'taki StreamBuilder giriş ekranına döner.
            FilledButton.icon(
              onPressed: () => context.read<AuthViewModel>().signOut(),
              icon: const Icon(Icons.logout),
              label: const Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
