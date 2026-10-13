class ImageUtils {
  static const supported = ['png', 'jpg', 'jpeg', 'webp', 'bmp', 'gif'];

  static bool isSupported(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot == -1) return true; // picker names can lack extensions
    return supported.contains(fileName.substring(dot + 1).toLowerCase());
  }

  static String formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
