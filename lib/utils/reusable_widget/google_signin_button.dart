import 'package:flutter/material.dart';
import '../app_sizes.dart';

/// Reusable Google Sign-In button widget
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.text = 'Continue with Google',
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isEnabled = enabled && !isLoading && onPressed != null;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 56.0,
      margin: margin,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1F1F1F),
          side: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppCommonSizes.borderRadiusM),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppCommonSizes.paddingXL,
            vertical: AppCommonSizes.paddingM,
          ),
          elevation: 0,
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.grey.shade600,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google Icon using actual logo
        Image.asset(
          'assets/logos/google.png',
          width: 20,
          height: 20,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to simple 'G' if image fails to load
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color(0xFF4285F4),
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(width: AppCommonSizes.paddingM),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F1F1F),
            ),
          ),
        ),
      ],
    );
  }
}

/// Alternative Google Sign-In button variants
class GoogleSignInButtonVariants {
  /// Google Sign-In button for login page
  static GoogleSignInButton login({
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return GoogleSignInButton(
      onPressed: onPressed,
      text: 'Sign in with Google',
      isLoading: isLoading,
    );
  }

  /// Google Sign-In button for signup page
  static GoogleSignInButton signup({
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return GoogleSignInButton(
      onPressed: onPressed,
      text: 'Sign up with Google',
      isLoading: isLoading,
    );
  }

  /// Compact Google Sign-In button with just icon
  static Widget compact({
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: 48,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppCommonSizes.borderRadiusM),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Image.asset(
                'assets/logos/google.png',
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color(0xFF4285F4),
                    ),
                    child: const Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}