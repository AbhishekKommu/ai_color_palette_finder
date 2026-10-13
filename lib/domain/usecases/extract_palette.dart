import '../../data/models/image_model.dart';
import '../../data/models/palette.dart';
import '../../data/repositories/palette_repository.dart';

class ExtractPalette {
  ExtractPalette(this._repo);
  final PaletteRepository _repo;

  Future<Palette> call(ImageModel image) => _repo.extract(image);
}
