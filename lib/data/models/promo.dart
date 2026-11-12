import 'package:flutter/material.dart';

class Promo {
  const Promo({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    this.accent = Colors.white,
  });

  final String tag;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final Color accent;

  LinearGradient get gradient => LinearGradient(
    colors: colors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
