import 'package:ai_color_palette_finder/services/color_analysis_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cluster finds two dominant colors', () {
    final pixels = <List<int>>[
      for (var i = 0; i < 50; i++) [255, 0, 0],
      for (var i = 0; i < 50; i++) [0, 0, 255],
    ];
    final result = ColorAnalysisService().cluster(pixels, 2);
    expect(result.length, 2);
    expect(result.map((c) => c.hex).toSet(), {'#FF0000', '#0000FF'});
    expect(result.first.percent, 50);
  });
}
