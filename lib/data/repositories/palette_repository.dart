import '../../services/ai_service.dart';
import '../../services/color_analysis_service.dart';
import '../models/color_result.dart';
import '../models/image_model.dart';
import '../models/palette.dart';

class PaletteRepository {
  PaletteRepository(this._analysis, this._ai);
  final ColorAnalysisService _analysis;
  final AiService _ai;

  Future<Palette> extract(ImageModel image) async {
    final colors = await _analysis.extractPalette(image.bytes);
    return Palette(
      colors: colors,
      imageName: image.name,
      insight: _ai.insight(colors),
    );
  }

  Map<String, List<ColorResult>> harmonies(ColorResult base) => _ai.harmonies(base);
}
