import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildHeroSection(theme),
                const SizedBox(height: 32),
                _buildScreenshotsSection(theme),
                const SizedBox(height: 32),
                _buildFeatures(theme),
                const SizedBox(height: 24),
                _buildCTA(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.extension, size: 28),
        const SizedBox(width: 8),
        Text(
          'Fuzzle',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        TextButton(
          onPressed: () => context.go('/'),
          child: const Text('Open App'),
        ),
      ],
    );
  }

  Widget _buildHeroSection(ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final title = Text(
          'A Focused Study App with Bluetooth Device Integration',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        );
        final subtitle = Text(
          'Fuzzle helps you manage study sessions, pair devices, and track progress across desktop, mobile, and web.',
          style: theme.textTheme.bodyLarge,
        );
        final image = ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/static/homePage.png',
            fit: BoxFit.cover,
            height: 280,
          ),
        );
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    const SizedBox(height: 12),
                    subtitle,
                  ],
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(width: 420, child: image),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            const SizedBox(height: 12),
            subtitle,
            const SizedBox(height: 16),
            image,
          ],
        );
      },
    );
  }

  Widget _buildScreenshotsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Screenshots', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _ShotCard(path: 'lib/static/StudySessionPage.png', label: 'Study Session'),
            _ShotCard(path: 'lib/static/CanvaStudySessionPage.png', label: 'Canva Concept'),
            _ShotCard(path: 'lib/static/loadingCat.png', label: 'Loading State'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatures(ThemeData theme) {
    final features = [
      'Clean routing with go_router',
      'State management via Provider',
      'Bluetooth pairing (mobile) with flutter_blue_plus',
      'Desktop window controls with window_manager',
      'Responsive web build and PWA manifest',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Highlights', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        ...features.map((f) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Icon(Icons.check_circle, color: Colors.green, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(f, style: theme.textTheme.bodyMedium)),
          ],
        )),
      ],
    );
  }

  Widget _buildCTA(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Launch App'),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            // Replace with your repository URL if needed
          },
          icon: const Icon(Icons.code),
          label: const Text('View Source'),
        ),
      ],
    );
  }
}

class _ShotCard extends StatelessWidget {
  final String path;
  final String label;
  const _ShotCard({required this.path, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
              height: 200,
              width: 320,
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}


