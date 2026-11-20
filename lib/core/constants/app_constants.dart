import 'package:flutter/material.dart';

/// Uygulama genelinde kullanılan renkler.
class AppColors {
  AppColors._();

  static const Color primary = Colors.deepOrange;
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
}

/// Boşluk ve köşe yuvarlaklığı ölçüleri (px).
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double cardRadius = 16;
}
