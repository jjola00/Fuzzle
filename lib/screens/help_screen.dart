import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            // === Help Overview ===
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.cardPadding),
                child: Column(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Help & Support',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get help with using ${AppConstants.appName} and find answers to common questions.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // === Help Topics ===
            Expanded(
              child: ListView(
                children: [
                  _buildHelpTile(
                    context,
                    'Getting Started',
                    'Learn how to set up your profile and start your first study session.',
                    Icons.play_arrow,
                  ),
                  _buildHelpTile(
                    context,
                    'Study Sessions',
                    'Tips for effective study sessions and tracking your progress.',
                    Icons.school,
                  ),
                  _buildHelpTile(
                    context,
                    'Settings & Preferences',
                    'Customize your experience and manage your personal data.',
                    Icons.settings,
                  ),
                  _buildHelpTile(
                    context,
                    'Troubleshooting',
                    'Common issues and solutions for the best app experience.',
                    Icons.build,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
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

  /// Creates a help topic tile with consistent styling and layout.
  Widget _buildHelpTile(BuildContext context, String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          size: AppConstants.iconSize * 0.6,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // TODO: Navigate to specific help topic details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title help coming soon!'),
              duration: const Duration(seconds: AppConstants.snackBarDuration),
            ),
          );
        },
      ),
    );
  }
} 