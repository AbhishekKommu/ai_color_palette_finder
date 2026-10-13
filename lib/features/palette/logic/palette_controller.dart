import 'package:flutter/foundation.dart';
import '../../../app/di.dart';
import '../../../data/models/color_result.dart';
import '../../../data/models/image_model.dart';
import '../../../data/models/palette.dart';

class PaletteController extends ChangeNotifier {
  bool loading = false;
  bool saved = false;
  String? error;
  Palette? palette;
  int selectedIndex = 0;

  ColorResult? get selected {
    final p = palette;
    if (p == null || p.colors.isEmpty) return null;
    return p.colors[selectedIndex.clamp(0, p.colors.length - 1)];
  }

  String get allHex => palette?.colors.map((c) => c.hex).join(', ') ?? '';

  Future<void> extractFrom(ImageModel image) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      palette = await Di.extractPalette(image);
      selectedIndex = 0;
    } catch (e) {
      error = e.toString();
    }
    loading = false;
    notifyListeners();
  }

  void showExisting(Palette existing) {
    palette = existing;
    saved = true; // already in history
    notifyListeners();
  }

  void select(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> save() async {
    final p = palette;
    if (p == null || saved) return;
    await Di.saveToHistory(p);
    saved = true;
    notifyListeners();
  }
}
