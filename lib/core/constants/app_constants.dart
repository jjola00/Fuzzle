import 'package:flutter/material.dart';

/// Application-wide constants for consistent styling, configuration, and behavior.
class AppConstants {
  // === Data Storage Keys ===
  /// Key for storing user's preferred name in SharedPreferences
  static const String userNameKey = 'user_name';
  /// Key for storing user's visit count for analytics
  static const String visitCountKey = 'visit_count';
  
  // === Default Values ===
  /// Default user name for new users or after data reset
  static const String defaultUserName = 'Parent';
  /// Initial visit count for new users
  static const int defaultVisitCount = 0;
  
  // === App Metadata ===
  /// Application display name
  static const String appName = 'Fuzzle';
  /// Current version for display in UI
  static const String appVersion = '1.0.0';
  
  static const double defaultPadding = 16.0;
  static const double cardPadding = 20.0;
  static const double iconSize = 48.0;
  static const int snackBarDuration = 2;
  
  // === Home Screen Design Constants ===
  /// Height for main action buttons to ensure touch accessibility
  static const double buttonHeight = 60.0;
  /// Border radius for buttons to match modern design standards
  static const double buttonBorderRadius = 30.0;
  /// Large logo font size for brand prominence
  static const double logoFontSize = 48.0;
  /// Button text size for optimal readability
  static const double buttonFontSize = 18.0;
  /// Size for bottom navigation buttons (square aspect ratio)
  static const double bottomButtonSize = 80.0;
  /// Vertical spacing between main action buttons
  static const double spaceBetweenMainButtons = 24.0;
  /// Vertical spacing between different UI sections
  static const double spaceBetweenSections = 40.0;
  
  static const Color primaryButtonColor = Color(0xFF5A5A6B);
  static const Color secondaryButtonColor = Color(0xFF9FA3C7);
  static const Color backgroundColor = Color(0xFFE8EAF6);
  static const Color bottomButtonColor = Color(0xFFB0BEC5);
  
  static const Color gradientStartColor = Color(0xFF7794B6);
  static const Color gradientEndColor = Color(0xFFDFFAFF);
} 