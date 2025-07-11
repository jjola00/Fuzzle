import 'package:flutter/material.dart';

class AppConstants {
  // Storage Keys
  static const String userNameKey = 'user_name';
  static const String visitCountKey = 'visit_count';
  
  // Default Values
  static const String defaultUserName = 'Parent';
  static const int defaultVisitCount = 0;
  
  // App Info
  static const String appName = 'Fuzzle';
  static const String appVersion = '1.0.0';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardPadding = 20.0;
  static const double iconSize = 48.0;
  static const int snackBarDuration = 2;
  
  // Home Page Design Constants
  static const double buttonHeight = 60.0;
  static const double buttonBorderRadius = 30.0;
  static const double logoFontSize = 48.0;
  static const double buttonFontSize = 18.0;
  static const double bottomButtonSize = 80.0;
  static const double spaceBetweenMainButtons = 24.0;
  static const double spaceBetweenSections = 40.0;
  
  // Colors for Home Page
  static const Color primaryButtonColor = Color(0xFF5A5A6B);
  static const Color secondaryButtonColor = Color(0xFF9FA3C7);
  static const Color backgroundColor = Color(0xFFE8EAF6);
  static const Color bottomButtonColor = Color(0xFFB0BEC5);
  
  // Gradient Background Colors
  static const Color gradientStartColor = Color(0xFF7794B6);
  static const Color gradientEndColor = Color(0xFFDFFAFF);
} 