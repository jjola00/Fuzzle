import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides a unified interface for persistent storage operations.
/// Handles SharedPreferences initialization and graceful error recovery.
class StorageService {
  static SharedPreferences? _prefs;
  
  /// Initialize the storage service. Must be called before using any other methods.
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint('Failed to initialize SharedPreferences: $e');
      rethrow;
    }
  }
  
  /// Returns true if the storage service has been properly initialized.
  static bool get isInitialized => _prefs != null;
  
  static Future<bool> saveString(String key, String value) async {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return false;
    }
    try {
      return await _prefs!.setString(key, value);
    } catch (e) {
      debugPrint('Failed to save string: $e');
      return false;
    }
  }
  
  static String? getString(String key) {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return null;
    }
    try {
      return _prefs!.getString(key);
    } catch (e) {
      debugPrint('Failed to get string: $e');
      return null;
    }
  }
  
  static Future<bool> saveInt(String key, int value) async {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return false;
    }
    try {
      return await _prefs!.setInt(key, value);
    } catch (e) {
      debugPrint('Failed to save int: $e');
      return false;
    }
  }
  
  static int getInt(String key, {int defaultValue = 0}) {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return defaultValue;
    }
    try {
      return _prefs!.getInt(key) ?? defaultValue;
    } catch (e) {
      debugPrint('Failed to get int: $e');
      return defaultValue;
    }
  }
  
  static Future<bool> saveBool(String key, bool value) async {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return false;
    }
    try {
      return await _prefs!.setBool(key, value);
    } catch (e) {
      debugPrint('Failed to save bool: $e');
      return false;
    }
  }
  
  static bool getBool(String key, {bool defaultValue = false}) {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return defaultValue;
    }
    try {
      return _prefs!.getBool(key) ?? defaultValue;
    } catch (e) {
      debugPrint('Failed to get bool: $e');
      return defaultValue;
    }
  }
  
  static Future<bool> remove(String key) async {
    if (!isInitialized) {
      debugPrint('StorageService not initialized');
      return false;
    }
    try {
      return await _prefs!.remove(key);
    } catch (e) {
      debugPrint('Failed to remove key: $e');
      return false;
    }
  }
}