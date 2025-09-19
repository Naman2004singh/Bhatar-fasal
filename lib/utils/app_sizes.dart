import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  /// Get screen dimensions
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get responsive value based on screen size
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (AppBreakpoints.isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (AppBreakpoints.isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.all(
      responsive(
        context,
        mobile: AppCommonSizes.paddingM,
        tablet: AppCommonSizes.paddingL,
        desktop: AppCommonSizes.paddingXL,
      ),
    );
  }
}

/// Splash Screen specific sizes
class AppSplashSizes {
  static const double logoWidthPercent = 0.95;
  static const double logoHeightPercent = 0.95;
  static const double fallbackIconPercent = 0.6;
  static const double containerPadding = 20.0;

  /// Get splash logo width
  static double getLogoWidth(BuildContext context) {
    return AppSizes.getScreenWidth(context) * logoWidthPercent;
  }

  /// Get splash logo height  
  static double getLogoHeight(BuildContext context) {
    return AppSizes.getScreenWidth(context) * logoHeightPercent;
  }

  /// Get fallback icon size
  static double getFallbackIconSize(BuildContext context) {
    return AppSizes.getScreenWidth(context) * fallbackIconPercent;
  }
}

/// Common UI sizes used throughout the app
class AppCommonSizes {
  // Padding & Margins
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 12.0;
  static const double borderRadiusXL = 16.0;

  // Icon Sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 44.0;
  static const double buttonHeightL = 52.0;
}

/// Responsive breakpoints for different screen sizes
class AppBreakpoints {
  static const double mobile = 480.0;
  static const double tablet = 768.0;
  static const double desktop = 1024.0;
  static const double largeDesktop = 1440.0;

  /// Check if screen is mobile
  static bool isMobile(BuildContext context) {
    return AppSizes.getScreenWidth(context) < mobile;
  }

  /// Check if screen is tablet
  static bool isTablet(BuildContext context) {
    final width = AppSizes.getScreenWidth(context);
    return width >= mobile && width < desktop;
  }

  /// Check if screen is desktop
  static bool isDesktop(BuildContext context) {
    return AppSizes.getScreenWidth(context) >= desktop;
  }
}