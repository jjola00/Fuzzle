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
            
            // Help sections
            Expanded(
              child: ListView(
                children: [
                  _buildHelpCard(
                    context,
                    'Getting Started',
                    'Learn how to use ${AppConstants.appName} effectively',
                    Icons.play_circle_outline,
                  ),
                  _buildHelpCard(
                    context,
                    'Study Tips',
                    'Best practices for effective studying',
                    Icons.lightbulb_outline,
                  ),
                  _buildHelpCard(
                    context,
                    'Troubleshooting',
                    'Common issues and solutions',
                    Icons.build_outlined,
                  ),
                  _buildHelpCard(
                    context,
                    'Contact Support',
                    'Get in touch with our support team',
                    Icons.contact_support_outlined,
                  ),
                ],
              ),
            ),
            
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
  
  Widget _buildHelpCard(BuildContext context, String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening $title...'),
              duration: const Duration(seconds: AppConstants.snackBarDuration),
            ),
          );
        },
      ),
    );
  }
} 