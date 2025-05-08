import 'package:flutter/material.dart';

/// Utility class to handle responsive design across different device sizes
class ResponsiveUtils {
  static final ResponsiveUtils _instance = ResponsiveUtils._internal();

  factory ResponsiveUtils() => _instance;

  ResponsiveUtils._internal();

  /// Singleton instance for easy access throughout the app
  static ResponsiveUtils get instance => _instance;

  /// Global reference to MediaQueryData - must be initialized in app startup
  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;
  late Orientation _orientation;

  /// Device types based on screen width
  bool get isPhone => _screenWidth < 600;
  bool get isTablet => _screenWidth >= 600 && _screenWidth < 1024;
  bool get isDesktop => _screenWidth >= 1024;

  /// Initialize with BuildContext to get MediaQueryData
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _orientation = _mediaQueryData.orientation;
  }

  /// Get screen width
  double get screenWidth => _screenWidth;

  /// Get screen height
  double get screenHeight => _screenHeight;

  /// Get orientation
  Orientation get orientation => _orientation;

  /// Get status bar height
  double get statusBarHeight => _mediaQueryData.padding.top;

  /// Get bottom padding (for notches, home indicators, etc.)
  double get bottomPadding => _mediaQueryData.padding.bottom;

  /// Scale width based on design width (default 393px from mockups)
  double scaleWidth(double width, {double designWidth = 393}) {
    return width * _screenWidth / designWidth;
  }

  /// Scale height based on design height (default 852px from mockups)
  double scaleHeight(double height, {double designHeight = 852}) {
    return height * _screenHeight / designHeight;
  }

  /// Get responsive font size
  double fontSize(double size) {
    if (isTablet) {
      // Slightly larger text on tablets
      return size * 1.2;
    } else if (isDesktop) {
      // Larger text on desktop/large tablets
      return size * 1.4;
    }
    return size;
  }

  /// Get responsive icon size
  double iconSize(double size) {
    if (isTablet) {
      return size * 1.2;
    } else if (isDesktop) {
      return size * 1.5;
    }
    return size;
  }

  /// Get responsive padding
  EdgeInsets getPadding(double padding) {
    if (isTablet) {
      return EdgeInsets.all(padding * 1.5);
    } else if (isDesktop) {
      return EdgeInsets.all(padding * 2);
    }
    return EdgeInsets.all(padding);
  }

  /// Get horizontal spacing
  double getHorizontalSpacing(double value) {
    return scaleWidth(value);
  }

  /// Get vertical spacing
  double getVerticalSpacing(double value) {
    return scaleHeight(value);
  }

  /// Get responsive border radius
  BorderRadius getBorderRadius(double radius) {
    if (isTablet) {
      return BorderRadius.circular(radius * 1.2);
    } else if (isDesktop) {
      return BorderRadius.circular(radius * 1.5);
    }
    return BorderRadius.circular(radius);
  }
}
