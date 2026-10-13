import '../../data/models/history_item.dart';
import '../../data/repositories/history_repository.dart';

class GetHistory {
  GetHistory(this._repo);
  final HistoryRepository _repo;

  Future<List<HistoryItem>> call() => _repo.getAll();
}
