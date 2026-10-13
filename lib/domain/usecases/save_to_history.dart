import '../../data/models/palette.dart';
import '../../data/repositories/history_repository.dart';

class SaveToHistory {
  SaveToHistory(this._repo);
  final HistoryRepository _repo;

  Future<void> call(Palette palette) => _repo.save(palette);
}
