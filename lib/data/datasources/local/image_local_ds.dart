import 'package:image_picker/image_picker.dart';
import '../../../services/image_service.dart';
import '../../models/image_model.dart';

class ImageLocalDs {
  ImageLocalDs(this._service);
  final ImageService _service;

  Future<ImageModel?> pick(ImageSource source) => _service.pick(source);
}
