import 'color_result.dart';

class Palette {
  final List<ColorResult> colors;
  final String imageName;
  final String insight;

  const Palette({
    required this.colors,
    required this.imageName,
    required this.insight,
  });

  Map<String, dynamic> toJson() => {
        'colors': colors.map((c) => c.toJson()).toList(),
        'imageName': imageName,
        'insight': insight,
      };

  factory Palette.fromJson(Map<String, dynamic> json) => Palette(
        colors: (json['colors'] as List)
            .map((e) => ColorResult.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
        imageName: json['imageName'] as String? ?? 'Image',
        insight: json['insight'] as String? ?? '',
      );
}
