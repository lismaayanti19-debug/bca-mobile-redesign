import 'package:bca_mobile_redesign/core/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatRupiah', () {
    test('adds thousand separators and the rupiah symbol', () {
      expect(formatRupiah(0), 'Rp 0');
      expect(formatRupiah(28000), 'Rp 28.000');
      expect(formatRupiah(12500000), 'Rp 12.500.000');
    });

    test('supports negative values without the symbol', () {
      expect(formatRupiah(-1250), '-Rp 1.250');
      expect(formatRupiah(8500, withSymbol: false), '8.500');
    });
  });

  group('formatCompactRupiah', () {
    test('uses Indonesian short units', () {
      expect(formatCompactRupiah(1850000), 'Rp 1,9 jt');
      expect(formatCompactRupiah(620000), 'Rp 620 rb');
      expect(formatCompactRupiah(2500000), 'Rp 2,5 jt');
      expect(formatCompactRupiah(1200000000), 'Rp 1,2 M');
    });
  });
}
