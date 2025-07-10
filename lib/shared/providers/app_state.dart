import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  String _userName = '';
  int _visitCount = 0;
  
  String get userName => _userName;
  int get visitCount => _visitCount;
  
  AppState() {
    _loadData();
  }
  
  void _loadData() {
    _userName = StorageService.getString('user_name') ?? 'Parent';
    _visitCount = StorageService.getInt('visit_count', defaultValue: 0);
    notifyListeners();
  }
  
  void setUserName(String name) {
    _userName = name;
    StorageService.saveString('user_name', name);
    notifyListeners();
  }
  
  void incrementVisit() {
    _visitCount++;
    StorageService.saveInt('visit_count', _visitCount);
    notifyListeners();
  }
  
  void resetData() {
    _userName = 'Parent';
    _visitCount = 0;
    StorageService.remove('user_name');
    StorageService.remove('visit_count');
    notifyListeners();
  }
}