import 'package:bca_mobile_redesign/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_fonts.dart';

Future<void> setViewport(
  WidgetTester tester,
  Size size, {
  double textScale = 1,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

  await tester.pumpWidget(const BcaMobileApp());
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  const sizes = <Size>[
    Size(320, 568),
    Size(360, 640),
    Size(390, 844),
    Size(430, 932),
    Size(768, 1024),
  ];

  for (final size in sizes) {
    testWidgets('lays out without overflow at ${size.width.toInt()}x'
        '${size.height.toInt()}', (tester) async {
      await setViewport(tester, size);

      // Visit every primary tab.
      for (final key in [
        'nav-aktivitas',
        'nav-promo',
        'nav-akun',
        'nav-beranda',
      ]) {
        await tester.tap(find.byKey(Key(key)));
        await tester.pumpAndSettle();
      }

      // Open every home sheet.
      await tester.tap(find.byKey(const Key('nav-qris')));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();
    });
  }

  testWidgets('supports larger accessibility text', (tester) async {
    await setViewport(tester, const Size(360, 640), textScale: 1.2);

    await tester.tap(find.byKey(const Key('nav-aktivitas')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('nav-promo')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('nav-akun')));
    await tester.pumpAndSettle();
  });
}
