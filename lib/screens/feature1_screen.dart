import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';

/// Feature 1 screen - development template for additional app functionality.
/// This screen serves as a placeholder and testing ground for new features
/// before they are integrated into the main application workflow.
class Feature1Screen extends StatelessWidget {
  const Feature1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 1'),
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
                      Icons.child_care,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Feature 1 Screen',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is where your first main feature will go. Perfect for testing navigation and layout.',
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
                // TODO: Implement feature 1 functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feature 1 is under development!'),
                    duration: Duration(seconds: AppConstants.snackBarDuration),
                  ),
                );
              },
              child: const Text('Test Feature 1'),
            ),
            
            const SizedBox(height: 16),
            
            OutlinedButton(
              onPressed: () {
                context.go('/feature2');
              },
              child: const Text('Go to Feature 2'),
            ),
            
            const SizedBox(height: 16),
            
            OutlinedButton(
              onPressed: () {
                context.go('/loading');
              },
              child: const Text('Test Loading Screen'),
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