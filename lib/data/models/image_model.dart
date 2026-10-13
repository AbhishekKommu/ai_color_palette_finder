import 'dart:typed_data';

class ImageModel {
  final Uint8List bytes;
  final String name;

  const ImageModel({required this.bytes, required this.name});
}
