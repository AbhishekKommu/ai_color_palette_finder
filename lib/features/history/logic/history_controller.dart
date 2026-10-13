import 'package:flutter/foundation.dart';
import '../../../app/di.dart';
import '../../../data/models/history_item.dart';

class HistoryController extends ChangeNotifier {
  List<HistoryItem> items = [];
  bool loading = true;

  Future<void> load() async {
    loading = true;
    notifyListeners();
    items = await Di.getHistory();
    loading = false;
    notifyListeners();
  }

  Future<void> remove(String id) async {
    await Di.historyRepository.remove(id);
    await load();
  }

  Future<void> clear() async {
    await Di.historyRepository.clear();
    await load();
  }
}
