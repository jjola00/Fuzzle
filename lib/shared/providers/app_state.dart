import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  String _userName = AppConstants.defaultUserName;
  int _visitCount = AppConstants.defaultVisitCount;
  
  String get userName => _userName;
  int get visitCount => _visitCount;
  
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