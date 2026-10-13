import 'dart:ui' show Color;
import '../../core/utils/color_utils.dart';

class ColorResult {
  final int r;
  final int g;
  final int b;
  final double percent; // share of the image (0..100), 0 if unknown

  const ColorResult({
    required this.r,
    required this.g,
    required this.b,
    this.percent = 0,
  });

  Color get color => ColorUtils.toColor(r, g, b);
  Color get onColor => ColorUtils.onColor(r, g, b);
  String get hex => ColorUtils.toHex(r, g, b);
  String get rgbString => 'rgb($r, $g, $b)';
  String get name => ColorUtils.nameFor(r, g, b);

  String get hslString {
    final h = ColorUtils.rgbToHsl(r, g, b);
    return 'hsl(${h.h.round()}, ${(h.s * 100).round()}%, ${(h.l * 100).round()}%)';
  }

  Map<String, dynamic> toJson() => {'r': r, 'g': g, 'b': b, 'p': percent};

  factory ColorResult.fromJson(Map<String, dynamic> json) => ColorResult(
        r: json['r'] as int,
        g: json['g'] as int,
        b: json['b'] as int,
        percent: (json['p'] as num?)?.toDouble() ?? 0,
      );
}
