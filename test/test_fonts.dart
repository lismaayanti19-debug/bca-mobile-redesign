import 'package:flutter/services.dart';

/// Loads the bundled Plus Jakarta Sans weights so widget tests measure text
/// with the same metrics as the real app.
Future<void> loadAppFonts() async {
  final loader = FontLoader('PlusJakartaSans');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold']) {
    loader.addFont(rootBundle.load('assets/fonts/PlusJakartaSans-$weight.ttf'));
  }
  await loader.load();
}
