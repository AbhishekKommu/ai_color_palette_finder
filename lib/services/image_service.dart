import 'package:image_picker/image_picker.dart';
import '../core/errors/exceptions.dart';
import '../data/models/image_model.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// Pick (gallery) or capture (camera) an image. Returns null if cancelled.
  Future<ImageModel?> pick(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 1600,
        imageQuality: 90,
      );
      if (file == null) return null;
      final bytes = await file.readAsBytes();
      return ImageModel(bytes: bytes, name: file.name);
    } catch (e) {
      throw ImagePickException('Could not open the image. $e');
    }
  }
}
