import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/study_screen.dart';
import '../screens/study_log_screen.dart';
import '../screens/help_screen.dart';
import '../screens/feature1_screen.dart';
import '../screens/feature2_screen.dart';
import '../screens/settings_screen.dart';

/// Routing configuration
/// Provides clean URLs and easy navigation management across the app.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/study',
      builder: (context, state) => const StudyScreen(),
    ),
    GoRoute(
      path: '/study-log',
      builder: (context, state) => const StudyLogScreen(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpScreen(),
    ),
    GoRoute(
      path: '/feature1',
      builder: (context, state) => const Feature1Screen(),
    ),
    GoRoute(
      path: '/feature2',
      builder: (context, state) => const Feature2Screen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);