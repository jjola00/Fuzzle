import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Session'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            // === Study Session Overview ===
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.cardPadding),
                child: Column(
                  children: [
                    Icon(
                      Icons.school,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Study Session',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start your focused study session here. Track your progress and stay motivated!',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // === Action Buttons ===
            ElevatedButton(
              onPressed: () {
                // TODO: Implement study session functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Study session feature coming soon!'),
                    duration: Duration(seconds: AppConstants.snackBarDuration),
                  ),
                );
              },
              child: const Text('Start Study Session'),
            ),
            
            const SizedBox(height: 16),
            
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