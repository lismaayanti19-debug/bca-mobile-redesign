/// Formats a number as Indonesian rupiah, e.g. `12500000` -> `Rp 12.500.000`.
String formatRupiah(num value, {bool withSymbol = true}) {
  final isNegative = value < 0;
  final digits = value.abs().round().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }

  final prefix = isNegative ? '-' : '';
  return '$prefix${withSymbol ? 'Rp ' : ''}$buffer';
}

/// Compact rupiah for tight spaces, e.g. `1850000` -> `Rp 1,9 jt`.
String formatCompactRupiah(num value) {
  if (value >= 1000000000) {
    return 'Rp ${_trimDecimal(value / 1000000000)} M';
  }
  if (value >= 1000000) {
    return 'Rp ${_trimDecimal(value / 1000000)} jt';
  }
  if (value >= 1000) {
    return 'Rp ${(value / 1000).round()} rb';
  }
  return formatRupiah(value);
}

String _trimDecimal(double value) {
  final text = value.toStringAsFixed(1).replaceAll('.', ',');
  return text.endsWith(',0') ? text.substring(0, text.length - 2) : text;
}
