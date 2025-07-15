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
  
  // === Asset Paths ===
  /// Main home screen background image with visual button designs
  static const String homePageImage = 'lib/static/homePage.png';
  /// Loading screen background image
  static const String loadingPageImage = 'lib/static/loadingPage.png';
  /// Fuzzle logo image for branding and loading screens
  static const String fuzzleLogoImage = 'lib/static/fuzzleLogo.png';
  /// Loading cat image for loading animation
  static const String loadingCatImage = 'lib/static/loadingCat.png';
  
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
  
  // === BUTTON POSITION RATIOS - UPDATE THESE FOR NEW HOME SCREEN IMAGE ===
  // To adjust button positions: change these decimal values (0.0 to 1.0)
  // where 0.0 is top/left edge and 1.0 is bottom/right edge
  
  // Main buttons (Study Now & Study Log)
  static const double mainButtonWidthRatio = 0.72;    // Button width
  static const double mainButtonHeightRatio = 0.09;   // Button height
  static const double horizontalPaddingRatio = 0.14; // Left margin
  
  // Study Now button position
  static const double studyNowTopRatio = 0.33;        // Top position
  
  // Study Log button position  
  static const double studyLogTopRatio = 0.445;        // Top position
  
  // Bottom buttons (Settings & Help)
  static const double bottomButtonsTopRatio = 0.685;   // Top position
  static const double bottomButtonWidthRatio = 0.35;  // Button width
  static const double bottomButtonHeightRatio = 0.07; // Button height
  static const double bottomButtonMarginRatio = 0.07; // Side margins
  
  // Bluetooth pairing button 
  static const double bluetoothButtonTopRatio = 0.65;  // Top position
  static const double bluetoothButtonWidthRatio = 0.6; // Button width
  static const double bluetoothButtonHeightRatio = 0.08; // Button height
  
  static const Color primaryButtonColor = Color(0xFF5A5A6B);
  static const Color secondaryButtonColor = Color(0xFF9FA3C7);
  static const Color backgroundColor = Color(0xFFE8EAF6);
  static const Color bottomButtonColor = Color(0xFFB0BEC5);
  static const Color bluetoothButtonColor = Color(0xFF4A90E2);
  
  static const Color gradientStartColor = Color(0xFF7794B6);
  static const Color gradientEndColor = Color(0xFFDFFAFF);
} 