import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/di.dart';
import '../../../data/models/image_model.dart';

class ImagePickerController extends ChangeNotifier {
  ImageModel? image;
  bool busy = false;
  String? error;

  Future<void> pick(ImageSource source) async {
    busy = true;
    error = null;
    notifyListeners();
    try {
      final picked = await Di.imageLocal.pick(source);
      if (picked != null) image = picked;
    } catch (e) {
      error = e.toString();
    }
    busy = false;
    notifyListeners();
  }
}
