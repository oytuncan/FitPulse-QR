import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beslenme')),
      body: Center(
        child:
            Text('Beslenme', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
