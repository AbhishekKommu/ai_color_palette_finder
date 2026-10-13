import 'package:flutter/material.dart';
import '../../data/models/color_result.dart';

/// A tappable color tile showing the HEX code (and share of the image).
class PaletteSwatch extends StatelessWidget {
  const PaletteSwatch({
    super.key,
    required this.color,
    this.selected = false,
    this.onTap,
    this.size = 104,
    this.showPercent = true,
    this.showHex = true,
  });

  final ColorResult color;
  final bool selected;
  final VoidCallback? onTap;
  final double size;
  final bool showPercent;
  final bool showHex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Colors.black87 : Colors.black12,
            width: selected ? 3 : 1,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHex)
              Text(
                color.hex,
                style: TextStyle(
                  color: color.onColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            if (showPercent && color.percent > 0)
              Text(
                '${color.percent.toStringAsFixed(1)}%',
                style: TextStyle(color: color.onColor, fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
