import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../config/localization/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../../shared/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            tooltip: AppStrings.history,
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Dot(Color(0xFFFF6B6B)),
                    _Dot(Color(0xFFFFD93D)),
                    _Dot(Color(0xFF6BCB77)),
                    _Dot(Color(0xFF4D96FF)),
                    _Dot(AppColors.primary),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Find the colors in any image',
                    textAlign: TextAlign.center, style: TextStyles.heading),
                const SizedBox(height: 12),
                const Text(AppStrings.tagline,
                    textAlign: TextAlign.center, style: TextStyles.muted),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: AppStrings.chooseImage,
                  icon: Icons.image_outlined,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.pickImage),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.history),
                    icon: const Icon(Icons.history),
                    label: const Text(AppStrings.history),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
