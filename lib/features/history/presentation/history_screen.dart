import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../config/localization/app_strings.dart';
import '../../../config/theme/text_styles.dart';
import '../../../data/models/history_item.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../palette/presentation/palette_screen.dart';
import '../logic/history_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _date(DateTime d) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}  ${two(d.hour)}:${two(d.minute)}';
  }

  Widget _tile(HistoryItem item) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.palette,
          arguments: PaletteArgs(palette: item.palette),
        ),
        title: Text(item.palette.imageName,
            maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyles.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      for (final c in item.palette.colors)
                        Expanded(child: Container(color: c.color)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(_date(item.createdAt), style: TextStyles.muted),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => _controller.remove(item.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.history),
            actions: [
              if (_controller.items.isNotEmpty)
                IconButton(
                  tooltip: 'Clear all',
                  icon: const Icon(Icons.delete_sweep_outlined),
                  onPressed: _controller.clear,
                ),
            ],
          ),
          body: _controller.loading
              ? const LoadingIndicator()
              : _controller.items.isEmpty
                  ? const EmptyState(
                      icon: Icons.history, message: AppStrings.noHistory)
                  : Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _controller.items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (_, i) => _tile(_controller.items[i]),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
