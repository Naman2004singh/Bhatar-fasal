import 'package:flutter/material.dart';
import '../app_sizes.dart';
import '../../themes/app_themes.dart';

/// Reusable button widget with consistent styling and customizable parameters
class AppButton extends StatelessWidget {
  // Required parameters
  final String text;
  final VoidCallback? onPressed;

  // Optional parameters for customization
  final AppButtonType type;
  final AppButtonSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? icon;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final TextStyle? textStyle;
  final double? elevation;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.textStyle,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: width,
      height: height ?? 56.0,
      margin: margin,
      child: _buildButton(context, theme),
    );
  }

  Widget _buildButton(BuildContext context, ThemeData theme) {
    final bool isEnabled = enabled && !isLoading && onPressed != null;
    
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppThemes.primaryColor,
            foregroundColor: textColor ?? AppThemes.whiteColor,
            padding: padding ?? _getButtonPadding(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppCommonSizes.borderRadiusM,
              ),
            ),
            elevation: elevation ?? 2,
            textStyle: textStyle ?? _getTextStyle(theme),
          ),
          child: _buildButtonContent(),
        );
        
      case AppButtonType.secondary:
        return OutlinedButton(
          onPressed: isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppThemes.primaryColor,
            backgroundColor: backgroundColor,
            padding: padding ?? _getButtonPadding(),
            side: BorderSide(
              color: borderColor ?? AppThemes.primaryColor,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppCommonSizes.borderRadiusM,
              ),
            ),
            textStyle: textStyle ?? _getTextStyle(theme),
          ),
          child: _buildButtonContent(),
        );
        
      case AppButtonType.text:
        return TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? AppThemes.primaryColor,
            backgroundColor: backgroundColor,
            padding: padding ?? _getButtonPadding(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppCommonSizes.borderRadiusM,
              ),
            ),
            textStyle: textStyle ?? _getTextStyle(theme),
          ),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: _getLoadingSize(),
        height: _getLoadingSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? AppThemes.whiteColor,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(width: AppCommonSizes.paddingS),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: AppCommonSizes.paddingL,
          vertical: AppCommonSizes.paddingS,
        );
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: AppCommonSizes.paddingXL,
          vertical: AppCommonSizes.paddingM,
        );
      case AppButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: AppCommonSizes.paddingXXL,
          vertical: AppCommonSizes.paddingL,
        );
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case AppButtonSize.small:
        return theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ) ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
      case AppButtonSize.medium:
        return theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ) ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case AppButtonSize.large:
        return theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ) ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }
}

/// Button type variants
enum AppButtonType {
  primary,   // Filled button with primary color
  secondary, // Outlined button
  text,      // Text button
}

/// Button size variants
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Predefined button variants for common use cases
class AppButtonVariants {
  /// Primary submit button
  static AppButton submit({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    double? width,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.primary,
      size: AppButtonSize.medium,
      isLoading: isLoading,
      icon: icon,
      width: width ?? double.infinity,
    );
  }

  /// Secondary action button
  static AppButton secondary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    double? width,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.secondary,
      size: AppButtonSize.medium,
      isLoading: isLoading,
      icon: icon,
      width: width ?? double.infinity,
    );
  }

  /// Text link button
  static AppButton textLink({
    required String text,
    required VoidCallback? onPressed,
    Color? textColor,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.text,
      size: AppButtonSize.medium,
      textColor: textColor,
    );
  }

  /// Danger/Delete button
  static AppButton danger({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    double? width,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.primary,
      size: AppButtonSize.medium,
      backgroundColor: AppThemes.errorColor,
      textColor: AppThemes.whiteColor,
      isLoading: isLoading,
      icon: icon,
      width: width ?? double.infinity,
    );
  }

  /// Success button
  static AppButton success({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    double? width,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.primary,
      size: AppButtonSize.medium,
      backgroundColor: AppThemes.successColor,
      textColor: AppThemes.whiteColor,
      isLoading: isLoading,
      icon: icon,
      width: width ?? double.infinity,
    );
  }
}