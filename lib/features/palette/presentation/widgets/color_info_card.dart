import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/localization/app_strings.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../data/models/color_result.dart';
import '../../../../shared/widgets/color_swatch.dart';

class ColorInfoCard extends StatelessWidget {
  const ColorInfoCard({
    super.key,
    required this.color,
    required this.harmonies,
  });

  final ColorResult color;
  final Map<String, List<ColorResult>> harmonies;

  Future<void> _copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${AppStrings.copied}: $text'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(color.name, style: TextStyles.title),
                      if (color.percent > 0)
                        Text('${color.percent.toStringAsFixed(1)}% of the image',
                            style: TextStyles.muted),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _row(context, 'HEX', color.hex),
            _row(context, 'RGB', color.rgbString),
            _row(context, 'HSL', color.hslString),
            const Divider(height: 28),
            const Text('Suggested color combinations', style: TextStyles.title),
            const SizedBox(height: 8),
            for (final entry in harmonies.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(entry.key, style: TextStyles.body),
                    ),
                    PaletteSwatch(color: color, size: 44, showPercent: false, showHex: false),
                    for (final c in entry.value) ...[
                      const SizedBox(width: 8),
                      PaletteSwatch(
                        color: c,
                        size: 44,
                        showPercent: false,
                        showHex: false,
                        onTap: () => _copy(context, c.hex),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 4),
            const Text('Tap a suggested color to copy its HEX code.',
                style: TextStyles.muted),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return InkWell(
      onTap: () => _copy(context, value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SizedBox(width: 48, child: Text(label, style: TextStyles.muted)),
            Expanded(child: Text(value, style: TextStyles.body)),
            const Icon(Icons.copy, size: 16, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
