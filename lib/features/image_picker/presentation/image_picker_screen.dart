import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/routes.dart';
import '../../../config/localization/app_strings.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/image_preview.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../palette/presentation/palette_screen.dart';
import '../logic/image_picker_controller.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final _controller = ImagePickerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.chooseImage)),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final image = _controller.image;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (image != null)
                    ImagePreview(bytes: image.bytes, height: 300)
                  else
                    const SizedBox(
                      height: 300,
                      child: EmptyState(
                        icon: Icons.image_outlined,
                        message: AppStrings.noImage,
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (_controller.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(_controller.error!,
                          style: const TextStyle(color: Colors.red)),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _controller.busy
                              ? null
                              : () => _controller.pick(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library_outlined),
                          label: const Text(AppStrings.gallery),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _controller.busy
                              ? null
                              : () => _controller.pick(ImageSource.camera),
                          icon: const Icon(Icons.photo_camera_outlined),
                          label: const Text(AppStrings.camera),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: AppStrings.extract,
                    icon: Icons.palette_outlined,
                    onPressed: image == null
                        ? null
                        : () => Navigator.pushNamed(
                              context,
                              AppRoutes.palette,
                              arguments: PaletteArgs(image: image),
                            ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
