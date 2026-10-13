import 'package:flutter/material.dart';
import '../../../../data/models/color_result.dart';
import '../../../../shared/widgets/color_swatch.dart';

class PaletteGrid extends StatelessWidget {
  const PaletteGrid({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<ColorResult> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (var i = 0; i < colors.length; i++)
          PaletteSwatch(
            color: colors[i],
            selected: i == selectedIndex,
            onTap: () => onSelect(i),
          ),
      ],
    );
  }
}
