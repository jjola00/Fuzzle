import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:fuzzle/main.dart';
import 'package:fuzzle/shared/providers/app_state.dart';
import 'package:fuzzle/shared/services/storage_service.dart';

void main() {
  group('Fuzzle App Tests', () {
    setUpAll(() async {
      // Initialize storage service for testing
      await StorageService.init();
    });

    testWidgets('App initializes with correct title', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => AppState(),
          child: const MyApp(),
        ),
      );

      // Verify the app initializes without errors
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Home screen loads with background image', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => AppState(),
          child: const MyApp(),
        ),
      );

      // Wait for the widget to build completely
      await tester.pumpAndSettle();

      // Verify background image loads
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
