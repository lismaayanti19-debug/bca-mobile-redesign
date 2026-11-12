import 'package:flutter/material.dart';

/// Central colour palette for the redesign.
///
/// The palette keeps BCA's signature blue as the anchor colour, paired with
/// a deep navy for surfaces that need contrast and a soft blue-grey canvas.
abstract final class AppColors {
  static const Color bcaBlue = Color(0xFF0060AF);
  static const Color bcaBlueDark = Color(0xFF00407A);
  static const Color bcaSky = Color(0xFF00A3E0);
  static const Color navy = Color(0xFF08243D);
  static const Color navySoft = Color(0xFF123F68);

  static const Color background = Color(0xFFF3F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF102A43);
  static const Color muted = Color(0xFF6B7F92);
  static const Color line = Color(0xFFE7EDF4);
  static const Color softBlue = Color(0xFFEAF3FB);

  static const Color success = Color(0xFF0E9F6E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFE02424);
  static const Color gold = Color(0xFFF2B84B);

  /// Soft elevation used by every card in the app.
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x0D0B2A45), blurRadius: 24, offset: Offset(0, 10)),
  ];
}
