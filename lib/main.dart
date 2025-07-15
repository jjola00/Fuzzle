import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'core/themes/app_theme.dart';
import 'config/routes.dart';
import 'shared/providers/app_state.dart';
import 'shared/services/storage_service.dart';
import 'shared/services/bluetooth_service.dart';

/// Entry point for the Fuzzle study application.
/// Configures desktop window management for optimal user experience.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Desktop platform configuration for consistent window behavior
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    
    WindowOptions windowOptions = const WindowOptions(
      size: Size(375, 812), 
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: true,
    );
    
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      // Constrain window size to prevent UI layout issues with image-based navigation
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.setMaximumSize(const Size(400, 900));
    });
  }
  
  // Initialize core services before app starts to prevent state management issues
  await StorageService.init();
  
  // Initialize Bluetooth service on mobile platforms where it's available
  if (Platform.isAndroid || Platform.isIOS) {
    try {
      await BluetoothService().initialize();
    } catch (e) {
      // Bluetooth initialization failure should not prevent app from starting
      debugPrint('Bluetooth initialization failed: $e');
    }
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

/// Root widget that configures the app-wide theme and routing.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fuzzle',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}