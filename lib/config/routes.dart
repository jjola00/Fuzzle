import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/feature1_screen.dart';
import '../screens/feature2_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
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