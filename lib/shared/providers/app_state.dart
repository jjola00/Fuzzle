import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../services/storage_service.dart';

/// Manages application-wide state for user preferences and usage analytics.
/// Automatically persists changes to storage and notifies listeners of updates.
class AppState extends ChangeNotifier {
  String _userName = AppConstants.defaultUserName;
  int _visitCount = AppConstants.defaultVisitCount;
  
  /// Current user name for personalized greetings and preferences.
  String get userName => _userName;
  
  /// Total number of times the user has visited the home screen.
  /// Used for engagement analytics and progressive onboarding.
  int get visitCount => _visitCount;
  
  /// Loads initial state from persistent storage when AppState is created.
  AppState() {
    _loadData();
  }
  
  void _loadData() {
    _userName = StorageService.getString(AppConstants.userNameKey) ?? AppConstants.defaultUserName;
    _visitCount = StorageService.getInt(AppConstants.visitCountKey, defaultValue: AppConstants.defaultVisitCount);
    notifyListeners();
  }
  
  void setUserName(String name) {
    _userName = name;
    StorageService.saveString(AppConstants.userNameKey, name);
    notifyListeners();
  }
  
  void incrementVisit() {
    _visitCount++;
    StorageService.saveInt(AppConstants.visitCountKey, _visitCount);
    notifyListeners();
  }
  
  void resetData() {
    _userName = AppConstants.defaultUserName;
    _visitCount = AppConstants.defaultVisitCount;
    StorageService.remove(AppConstants.userNameKey);
    StorageService.remove(AppConstants.visitCountKey);
    notifyListeners();
  }
}