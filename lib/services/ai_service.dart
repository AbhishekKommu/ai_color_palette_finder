import '../core/utils/color_utils.dart';
import '../data/models/color_result.dart';

/// Smart suggestions computed on-device (no API key needed).
class AiService {
  /// Color-theory harmonies for a base color.
  Map<String, List<ColorResult>> harmonies(ColorResult base) {
    final hsl = ColorUtils.rgbToHsl(base.r, base.g, base.b);

    ColorResult shift(double dh, {double dl = 0}) {
      final rgb = ColorUtils.hslToRgb(hsl.h + dh, hsl.s, hsl.l + dl);
      return ColorResult(r: rgb[0], g: rgb[1], b: rgb[2]);
    }

    return {
      'Complementary': [shift(180)],
      'Analogous': [shift(-30), shift(30)],
      'Triadic': [shift(120), shift(240)],
      'Split complementary': [shift(150), shift(210)],
      'Monochrome': [shift(0, dl: -0.2), shift(0, dl: 0.2)],
    };
  }

  /// One-paragraph description of the palette mood and where to use it.
  String insight(List<ColorResult> colors) {
    if (colors.isEmpty) return 'No colors found.';
    double warm = 0, cool = 0, sat = 0, light = 0, total = 0;
    for (final c in colors) {
      final w = c.percent <= 0 ? 1.0 : c.percent;
      final h = ColorUtils.rgbToHsl(c.r, c.g, c.b);
      total += w;
      sat += h.s * w;
      light += h.l * w;
      if (h.s > 0.15) {
        if (h.h < 70 || h.h >= 300) {
          warm += w;
        } else {
          cool += w;
        }
      }
    }
    sat /= total;
    light /= total;

    final temp = warm > cool * 1.3
        ? 'warm'
        : cool > warm * 1.3
            ? 'cool'
            : 'balanced';
    final tone = sat > 0.55 ? 'vibrant' : (sat > 0.25 ? 'soft' : 'muted');
    final bright = light > 0.65 ? 'light' : (light < 0.35 ? 'dark' : 'medium-toned');
    final use = tone == 'vibrant'
        ? 'bold headings, buttons and call-to-action elements'
        : tone == 'soft'
            ? 'branding, illustrations and friendly interfaces'
            : 'backgrounds, cards and calm layouts';
    final top = colors.first;
    return 'This palette feels $temp, $tone and $bright. '
        'The dominant color is ${top.name} (${top.hex}). '
        'It works well for $use.';
  }
}
