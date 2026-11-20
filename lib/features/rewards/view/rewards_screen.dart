import 'package:flutter/material.dart';

/// Mağaza sekmesi (puanlarla ödül alma).
class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mağaza')),
      body: Center(
        child: Text('Mağaza', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
