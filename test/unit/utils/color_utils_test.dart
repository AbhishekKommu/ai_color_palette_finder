import 'package:ai_color_palette_finder/core/utils/color_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toHex formats uppercase hex', () {
    expect(ColorUtils.toHex(255, 0, 0), '#FF0000');
    expect(ColorUtils.toHex(0, 128, 255), '#0080FF');
  });

  test('HSL round trip is close', () {
    final hsl = ColorUtils.rgbToHsl(200, 100, 50);
    final rgb = ColorUtils.hslToRgb(hsl.h, hsl.s, hsl.l);
    expect((rgb[0] - 200).abs() <= 1, isTrue);
    expect((rgb[1] - 100).abs() <= 1, isTrue);
    expect((rgb[2] - 50).abs() <= 1, isTrue);
  });
}
