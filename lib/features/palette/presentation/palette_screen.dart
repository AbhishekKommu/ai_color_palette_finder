import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/di.dart';
import '../../../config/localization/app_strings.dart';
import '../../../config/theme/text_styles.dart';
import '../../../data/models/image_model.dart';
import '../../../data/models/palette.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/image_preview.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../logic/palette_controller.dart';
import 'widgets/color_info_card.dart';
import 'widgets/palette_grid.dart';

/// Pass either a fresh [image] to analyse or an existing [palette] (from history).
class PaletteArgs {
  final ImageModel? image;
  final Palette? palette;
  const PaletteArgs({this.image, this.palette});
}

class PaletteScreen extends StatefulWidget {
  const PaletteScreen({super.key});

  @override
  State<PaletteScreen> createState() => _PaletteScreenState();
}

class _PaletteScreenState extends State<PaletteScreen> {
  final _controller = PaletteController();
  ImageModel? _image;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is PaletteArgs) {
      if (args.palette != null) {
        _controller.showExisting(args.palette!);
      } else if (args.image != null) {
        _image = args.image;
        _controller.extractFrom(args.image!);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await _controller.save();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.saved), duration: Duration(seconds: 1)),
    );
  }

  Future<void> _copyAll() async {
    await Clipboard.setData(ClipboardData(text: _controller.allHex));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All HEX codes copied'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final palette = _controller.palette;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Palette'),
            actions: [
              if (palette != null) ...[
                IconButton(
                  tooltip: 'Copy all HEX codes',
                  icon: const Icon(Icons.copy_all),
                  onPressed: _copyAll,
                ),
                IconButton(
                  tooltip: AppStrings.saved,
                  icon: Icon(_controller.saved ? Icons.bookmark : Icons.bookmark_border),
                  onPressed: _controller.saved ? null : _save,
                ),
              ],
            ],
          ),
          body: _body(palette),
        );
      },
    );
  }

  Widget _body(Palette? palette) {
    if (_controller.loading) {
      return const LoadingIndicator(message: 'Analysing colors...');
    }
    if (_controller.error != null) {
      return EmptyState(icon: Icons.error_outline, message: _controller.error!);
    }
    if (palette == null || palette.colors.isEmpty) {
      return const EmptyState(icon: Icons.palette_outlined, message: 'No palette available');
    }
    final selected = _controller.selected!;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (_image != null) ...[
              ImagePreview(bytes: _image!.bytes, height: 220),
              const SizedBox(height: 16),
            ],
            // proportional color bar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 36,
                child: Row(
                  children: [
                    for (final c in palette.colors)
                      Expanded(
                        flex: (c.percent * 10).round().clamp(1, 1000),
                        child: Container(color: c.color),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_awesome),
                    const SizedBox(width: 12),
                    Expanded(child: Text(palette.insight, style: TextStyles.body)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Dominant colors', style: TextStyles.title),
            const SizedBox(height: 12),
            PaletteGrid(
              colors: palette.colors,
              selectedIndex: _controller.selectedIndex,
              onSelect: _controller.select,
            ),
            const SizedBox(height: 20),
            ColorInfoCard(
              color: selected,
              harmonies: Di.aiService.harmonies(selected),
            ),
          ],
        ),
      ),
    );
  }
}
