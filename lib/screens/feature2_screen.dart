import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';

/// Feature 2 screen - development template for additional app functionality.
/// This screen serves as a placeholder and testing ground for new features
/// before they are integrated into the main application workflow.
class Feature2Screen extends StatelessWidget {
  const Feature2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            // === Feature Overview ===
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.cardPadding),
                child: Column(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Feature 2 Screen',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is your second main feature screen. Great for testing different layouts and interactions.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // === Development Actions ===
            ElevatedButton(
              onPressed: () {
                // TODO: Implement feature 2 functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feature 2 is under development!'),
                    duration: Duration(seconds: AppConstants.snackBarDuration),
                  ),
                );
              },
              child: const Text('Test Feature 2'),
            ),
            
            const SizedBox(height: 16),
            
            OutlinedButton(
              onPressed: () {
                context.go('/feature1');
              },
              child: const Text('Go to Feature 1'),
            ),
            
            const Spacer(),
            
            OutlinedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}