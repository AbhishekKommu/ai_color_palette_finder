import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
  );
  static const TextStyle muted = TextStyle(
    fontSize: 13,
    color: AppColors.textMuted,
  );
}
