import '../data/datasources/local/history_local_ds.dart';
import '../data/datasources/local/image_local_ds.dart';
import '../data/repositories/history_repository.dart';
import '../data/repositories/palette_repository.dart';
import '../domain/usecases/extract_palette.dart';
import '../domain/usecases/get_history.dart';
import '../domain/usecases/save_to_history.dart';
import '../services/ai_service.dart';
import '../services/color_analysis_service.dart';
import '../services/image_service.dart';
import '../services/storage_service.dart';

/// Very small service locator (lazy static singletons).
class Di {
  static final storage = StorageService();
  static final imageService = ImageService();
  static final colorAnalysis = ColorAnalysisService();
  static final aiService = AiService();

  static final historyLocal = HistoryLocalDs(storage);
  static final imageLocal = ImageLocalDs(imageService);

  static final paletteRepository = PaletteRepository(colorAnalysis, aiService);
  static final historyRepository = HistoryRepository(historyLocal);

  static final extractPalette = ExtractPalette(paletteRepository);
  static final saveToHistory = SaveToHistory(historyRepository);
  static final getHistory = GetHistory(historyRepository);
}
