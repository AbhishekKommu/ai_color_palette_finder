import '../datasources/local/history_local_ds.dart';
import '../models/history_item.dart';
import '../models/palette.dart';

class HistoryRepository {
  HistoryRepository(this._local);
  final HistoryLocalDs _local;

  Future<List<HistoryItem>> getAll() => _local.getAll();

  Future<void> save(Palette palette) => _local.add(HistoryItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        palette: palette,
      ));

  Future<void> remove(String id) => _local.remove(id);
  Future<void> clear() => _local.clear();
}
