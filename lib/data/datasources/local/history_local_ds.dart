import 'dart:convert';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../services/storage_service.dart';
import '../../models/history_item.dart';

class HistoryLocalDs {
  HistoryLocalDs(this._storage);
  final StorageService _storage;

  Future<List<HistoryItem>> getAll() async {
    final raw = await _storage.readStringList(StorageKeys.history);
    final items = <HistoryItem>[];
    for (final s in raw) {
      try {
        items.add(HistoryItem.fromJson(jsonDecode(s) as Map<String, dynamic>));
      } catch (_) {
        // skip corrupted entries
      }
    }
    return items;
  }

  Future<void> add(HistoryItem item) async {
    final items = await getAll();
    items.insert(0, item);
    await _write(items.take(AppConstants.maxHistory).toList());
  }

  Future<void> remove(String id) async {
    final items = await getAll();
    items.removeWhere((e) => e.id == id);
    await _write(items);
  }

  Future<void> clear() => _write(const []);

  Future<void> _write(List<HistoryItem> items) => _storage.writeStringList(
        StorageKeys.history,
        items.map((e) => jsonEncode(e.toJson())).toList(),
      );
}
