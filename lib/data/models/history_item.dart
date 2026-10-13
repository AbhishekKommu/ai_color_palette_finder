import 'palette.dart';

class HistoryItem {
  final String id;
  final DateTime createdAt;
  final Palette palette;

  const HistoryItem({
    required this.id,
    required this.createdAt,
    required this.palette,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'palette': palette.toJson(),
      };

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
        id: json['id'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
        palette: Palette.fromJson(Map<String, dynamic>.from(json['palette'] as Map)),
      );
}
