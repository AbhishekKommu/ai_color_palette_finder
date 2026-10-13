import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import '../core/constants/app_constants.dart';
import '../core/errors/exceptions.dart';
import '../data/models/color_result.dart';

/// Extracts dominant colors using k-means clustering on downsampled pixels.
class ColorAnalysisService {
  Future<List<ColorResult>> extractPalette(
    Uint8List bytes, {
    int count = AppConstants.paletteSize,
  }) async {
    final ui.Codec codec;
    try {
      codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: AppConstants.sampleWidth,
      );
    } catch (_) {
      throw const PaletteException('This image format is not supported.');
    }
    final frame = await codec.getNextFrame();
    final image = frame.image;
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    codec.dispose();
    if (data == null) {
      throw const PaletteException('Could not read the image pixels.');
    }

    final raw = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final pixels = <List<int>>[];
    for (var i = 0; i + 3 < raw.length; i += 4) {
      if (raw[i + 3] < 128) continue; // skip transparent pixels
      pixels.add([raw[i], raw[i + 1], raw[i + 2]]);
    }
    if (pixels.isEmpty) {
      throw const PaletteException('The image has no visible pixels.');
    }
    return cluster(pixels, count);
  }

  /// k-means over RGB pixels. Result is sorted by dominance (largest first).
  List<ColorResult> cluster(List<List<int>> pixels, int k) {
    k = math.min(k, pixels.length);
    if (k <= 0) return [];

    // Farthest-point initialisation (deterministic and well spread).
    final centers = <List<double>>[
      pixels.first.map((e) => e.toDouble()).toList(),
    ];
    while (centers.length < k) {
      double bestDist = -1;
      List<int> best = pixels.first;
      for (final p in pixels) {
        double nearest = double.infinity;
        for (final c in centers) {
          final d = _dist(p, c);
          if (d < nearest) nearest = d;
        }
        if (nearest > bestDist) {
          bestDist = nearest;
          best = p;
        }
      }
      centers.add(best.map((e) => e.toDouble()).toList());
    }

    var counts = List<int>.filled(k, 0);
    for (var iter = 0; iter < AppConstants.kMeansIterations; iter++) {
      final sums = List.generate(k, (_) => <double>[0, 0, 0]);
      counts = List<int>.filled(k, 0);
      for (final p in pixels) {
        var bi = 0;
        var bd = double.infinity;
        for (var i = 0; i < k; i++) {
          final d = _dist(p, centers[i]);
          if (d < bd) {
            bd = d;
            bi = i;
          }
        }
        sums[bi][0] += p[0];
        sums[bi][1] += p[1];
        sums[bi][2] += p[2];
        counts[bi]++;
      }
      for (var i = 0; i < k; i++) {
        if (counts[i] == 0) continue;
        centers[i] = [
          sums[i][0] / counts[i],
          sums[i][1] / counts[i],
          sums[i][2] / counts[i],
        ];
      }
    }

    final total = pixels.length;
    final results = <ColorResult>[];
    for (var i = 0; i < k; i++) {
      if (counts[i] == 0) continue;
      results.add(ColorResult(
        r: centers[i][0].round().clamp(0, 255),
        g: centers[i][1].round().clamp(0, 255),
        b: centers[i][2].round().clamp(0, 255),
        percent: counts[i] / total * 100,
      ));
    }
    results.sort((a, b) => b.percent.compareTo(a.percent));
    return results;
  }

  double _dist(List<int> p, List<double> c) {
    final dr = p[0] - c[0], dg = p[1] - c[1], db = p[2] - c[2];
    return dr * dr + dg * dg + db * db;
  }
}
