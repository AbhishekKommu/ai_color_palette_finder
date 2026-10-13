class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class ImagePickException extends AppException {
  const ImagePickException(super.message);
}

class PaletteException extends AppException {
  const PaletteException(super.message);
}
