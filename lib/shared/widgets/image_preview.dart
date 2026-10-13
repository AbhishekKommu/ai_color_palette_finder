import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.bytes, this.height = 240});

  final Uint8List bytes;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.memory(bytes, fit: BoxFit.cover),
      ),
    );
  }
}
