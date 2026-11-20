import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tara')),
      body: Center(
        child: Text('Tara', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
