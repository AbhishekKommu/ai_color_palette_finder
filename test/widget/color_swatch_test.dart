import 'package:ai_color_palette_finder/data/models/color_result.dart';
import 'package:ai_color_palette_finder/shared/widgets/color_swatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PaletteSwatch shows hex code', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: PaletteSwatch(color: ColorResult(r: 255, g: 0, b: 0, percent: 50)),
      ),
    ));
    expect(find.text('#FF0000'), findsOneWidget);
  });
}
