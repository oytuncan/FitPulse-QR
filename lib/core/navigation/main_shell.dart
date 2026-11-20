import 'package:flutter/material.dart';

import '../../features/home/view/home_screen.dart';
import '../../features/machines/view/machine_scan_screen.dart';
import '../../features/nutrition/view/nutrition_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/rewards/view/rewards_screen.dart';

/// Giriş yapılmış kullanıcının ana iskeleti: alt gezinme çubuğu + 5 sekme.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _scanTab = 1;

  @override
  Widget build(BuildContext context) {
    // Sıra, aşağıdaki NavigationBar sekmeleriyle aynı olmalı.
    final screens = [
      const HomeScreen(),
      // Tara ekranı yalnızca sekme seçiliyken oluşturulur; böylece kamera
      // arka planda çalışmaz ve sekmeden çıkınca kapanır.
      _index == _scanTab ? const MachineScanScreen() : const SizedBox.shrink(),
      const NutritionScreen(),
      const RewardsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      // IndexedStack: sekme değişince ekranların durumu korunur.
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Tara',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Beslenme',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Mağaza',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
