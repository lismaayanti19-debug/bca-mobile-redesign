// Generates the screenshots used in the README.
//
// This file lives outside `test/` on purpose so the regular test suite remains
// fast. Run it with:
//
//   flutter test tool/screenshots/screenshot_test.dart --update-goldens
//
import 'package:bca_mobile_redesign/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _loadFonts() async {
  final loader = FontLoader('PlusJakartaSans');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold']) {
    loader.addFont(rootBundle.load('assets/fonts/PlusJakartaSans-$weight.ttf'));
  }
  await loader.load();
}

Future<void> _pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(860, 1864);
  tester.view.devicePixelRatio = 2;
  tester.view.padding = const FakeViewPadding(top: 70, bottom: 0);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPadding);

  await tester.pumpWidget(const BcaMobileApp());
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(_loadFonts);

  testWidgets('home screenshots', (tester) async {
    await _pumpApp(tester);

    await expectLater(
      find.byType(BcaMobileApp),
      matchesGoldenFile('goldens/home.png'),
    );

    await tester.drag(
      find.byType(CustomScrollView).first,
      const Offset(0, -620),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BcaMobileApp),
      matchesGoldenFile('goldens/home-transactions.png'),
    );
  });

  testWidgets('activity screenshot', (tester) async {
    await _pumpApp(tester);
    await tester.tap(find.byKey(const Key('nav-aktivitas')));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BcaMobileApp),
      matchesGoldenFile('goldens/activity.png'),
    );
  });

  testWidgets('promo screenshot', (tester) async {
    await _pumpApp(tester);
    await tester.tap(find.byKey(const Key('nav-promo')));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BcaMobileApp),
      matchesGoldenFile('goldens/promo.png'),
    );
  });

  testWidgets('account screenshot', (tester) async {
    await _pumpApp(tester);
    await tester.tap(find.byKey(const Key('nav-akun')));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BcaMobileApp),
      matchesGoldenFile('goldens/account.png'),
    );
  });

  testWidgets('qris sheet screenshot', (tester) async {
    await _pumpApp(tester);
    await tester.tap(find.byKey(const Key('nav-qris')));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BcaMobileApp),
      matchesGoldenFile('goldens/qris.png'),
    );
  });
}
