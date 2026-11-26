import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Visual variants supported by [AppButton].
enum AppButtonVariant {
  primary,
  secondary,
  outlined,
}

/// Reusable button component shared across JobHub feature screens.
///
/// Supports loading state (disables presses and shows a spinner), optional
/// leading [icon], [fullWidth] layout, and [variant] styling.
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final AppButtonVariant? variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.variant,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  AppButtonVariant get _effectiveVariant {
    if (variant != null) return variant!;
    return isSecondary ? AppButtonVariant.secondary : AppButtonVariant.primary;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveVariant = _effectiveVariant;
    final effectiveOnPressed = isLoading ? null : onPressed;

    final Widget content = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: effectiveVariant == AppButtonVariant.primary
                  ? Colors.white
                  : AppColors.primaryNavy,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: switch (effectiveVariant) {
                    AppButtonVariant.primary => Colors.white,
                    AppButtonVariant.secondary => AppColors.primaryNavy,
                    AppButtonVariant.outlined => AppColors.primaryBlue,
                  },
                ),
              ),
            ],
          );

    final Widget button = switch (effectiveVariant) {
      AppButtonVariant.outlined => OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryBlue,
            side: const BorderSide(color: AppColors.borderLight, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            ),
          ),
          onPressed: effectiveOnPressed,
          child: content,
        ),
      AppButtonVariant.primary || AppButtonVariant.secondary => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveVariant == AppButtonVariant.secondary
                ? AppColors.accentCyan
                : AppColors.primaryBlue,
            foregroundColor: effectiveVariant == AppButtonVariant.secondary
                ? AppColors.primaryNavy
                : Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            ),
          ),
          onPressed: effectiveOnPressed,
          child: content,
        ),
    };

    if (!fullWidth) return button;

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
