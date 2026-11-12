import 'package:bca_mobile_redesign/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const BcaMobileApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('home shows the redesigned sections', (tester) async {
    await pumpApp(tester);

    expect(find.text('Aditya Ramadhan'), findsOneWidget);
    expect(find.text('Layanan Cepat'), findsOneWidget);
    expect(find.text('Promo & Penawaran'), findsOneWidget);
    expect(find.text('Rp 12.500.000'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Transaksi Terakhir'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Insight Pengeluaran'), findsOneWidget);
    expect(find.text('Transaksi Terakhir'), findsOneWidget);
    expect(find.text('Kopi Kenangan'), findsOneWidget);
  });

  testWidgets('balance can be hidden and shown again', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('balance-visibility-toggle')));
    await tester.pumpAndSettle();

    expect(find.text('Rp 12.500.000'), findsNothing);
    expect(find.text('Rp ••••••••'), findsOneWidget);

    await tester.tap(find.byKey(const Key('balance-visibility-toggle')));
    await tester.pumpAndSettle();

    expect(find.text('Rp 12.500.000'), findsOneWidget);
  });

  testWidgets('bottom navigation opens the activity page', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('nav-aktivitas')));
    await tester.pumpAndSettle();

    expect(find.text('Semua transaksi kamu di satu tempat'), findsOneWidget);
    expect(find.text('Ringkasan November'), findsOneWidget);
  });

  testWidgets('activity filters only show incoming transactions', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('nav-aktivitas')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('filter-masuk')));
    await tester.pumpAndSettle();

    expect(find.text('Transfer dari Rina'), findsOneWidget);
    expect(find.text('Kopi Kenangan'), findsNothing);
  });
}
