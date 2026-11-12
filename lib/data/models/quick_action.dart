import 'package:flutter/material.dart';

class QuickAction {
  const QuickAction({
    required this.label,
    required this.icon,
    this.highlighted = false,
    this.neutral = false,
  });

  final String label;
  final IconData icon;

  /// Filled blue tile, reserved for the most important action (QRIS).
  final bool highlighted;

  /// Neutral grey tile, used for the "Lainnya" entry.
  final bool neutral;
}
