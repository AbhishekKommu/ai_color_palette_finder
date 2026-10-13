import 'dart:math' as math;
import 'dart:ui' show Color;

class Hsl {
  final double h; // 0..360
  final double s; // 0..1
  final double l; // 0..1
  const Hsl(this.h, this.s, this.l);
}

class ColorUtils {
  static String _hex2(int v) =>
      v.clamp(0, 255).toRadixString(16).padLeft(2, '0').toUpperCase();

  static String toHex(int r, int g, int b) => '#${_hex2(r)}${_hex2(g)}${_hex2(b)}';

  static Color toColor(int r, int g, int b) => Color.fromARGB(255, r, g, b);

  static Hsl rgbToHsl(int r, int g, int b) {
    final rf = r / 255, gf = g / 255, bf = b / 255;
    final maxV = math.max(rf, math.max(gf, bf));
    final minV = math.min(rf, math.min(gf, bf));
    final l = (maxV + minV) / 2;
    final d = maxV - minV;
    double h = 0, s = 0;
    if (d != 0) {
      s = l > 0.5 ? d / (2 - maxV - minV) : d / (maxV + minV);
      if (maxV == rf) {
        h = ((gf - bf) / d) + (gf < bf ? 6 : 0);
      } else if (maxV == gf) {
        h = ((bf - rf) / d) + 2;
      } else {
        h = ((rf - gf) / d) + 4;
      }
      h *= 60;
    }
    return Hsl(h, s, l);
  }

  static List<int> hslToRgb(double h, double s, double l) {
    h = ((h % 360) + 360) % 360;
    s = s.clamp(0.0, 1.0);
    l = l.clamp(0.0, 1.0);
    final c = (1 - (2 * l - 1).abs()) * s;
    final x = c * (1 - ((h / 60) % 2 - 1).abs());
    final m = l - c / 2;
    double r = 0, g = 0, b = 0;
    if (h < 60) {
      r = c;
      g = x;
    } else if (h < 120) {
      r = x;
      g = c;
    } else if (h < 180) {
      g = c;
      b = x;
    } else if (h < 240) {
      g = x;
      b = c;
    } else if (h < 300) {
      r = x;
      b = c;
    } else {
      r = c;
      b = x;
    }
    return [
      ((r + m) * 255).round().clamp(0, 255),
      ((g + m) * 255).round().clamp(0, 255),
      ((b + m) * 255).round().clamp(0, 255),
    ];
  }

  /// Readable text color (black/white) for a given background.
  static Color onColor(int r, int g, int b) {
    final lum = 0.299 * r + 0.587 * g + 0.114 * b;
    return lum > 150 ? const Color(0xFF111111) : const Color(0xFFFFFFFF);
  }

  /// Rough human-friendly color name.
  static String nameFor(int r, int g, int b) {
    final hsl = rgbToHsl(r, g, b);
    if (hsl.l < 0.1) return 'Black';
    if (hsl.l > 0.93) return 'White';
    if (hsl.s < 0.12) {
      if (hsl.l < 0.35) return 'Dark Gray';
      if (hsl.l > 0.7) return 'Light Gray';
      return 'Gray';
    }
    final h = hsl.h;
    String base;
    if (h < 15 || h >= 345) {
      base = 'Red';
    } else if (h < 45) {
      base = 'Orange';
    } else if (h < 70) {
      base = 'Yellow';
    } else if (h < 95) {
      base = 'Lime';
    } else if (h < 165) {
      base = 'Green';
    } else if (h < 195) {
      base = 'Teal';
    } else if (h < 215) {
      base = 'Cyan';
    } else if (h < 255) {
      base = 'Blue';
    } else if (h < 290) {
      base = 'Purple';
    } else {
      base = 'Pink';
    }
    if (hsl.l > 0.72) return 'Light $base';
    if (hsl.l < 0.28) return 'Dark $base';
    return base;
  }
}
