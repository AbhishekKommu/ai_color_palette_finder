import 'package:flutter/widgets.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/image_picker/presentation/image_picker_screen.dart';
import '../features/palette/presentation/palette_screen.dart';

class AppRoutes {
  static const home = '/';
  static const pickImage = '/pick';
  static const palette = '/palette';
  static const history = '/history';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    pickImage: (_) => const ImagePickerScreen(),
    palette: (_) => const PaletteScreen(),
    history: (_) => const HistoryScreen(),
  };
}
