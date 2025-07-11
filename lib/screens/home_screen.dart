import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../shared/providers/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Increment visit count when home screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().incrementVisit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.gradientStartColor,
              AppConstants.gradientEndColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                // Top spacing
                const SizedBox(height: 60),
                
                // Fuzzle Logo Section - Using Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'lib/static/fuzzle.png',
                      fit: BoxFit.contain,
                      height: 120, // Adjust height as needed
                    ),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spaceBetweenSections),
                
                // Main Action Buttons
                Column(
                  children: [
                    // Study Now Button - Using Image
                    GestureDetector(
                      onTap: () {
                        context.go('/study');
                      },
                      child: Container(
                        width: double.infinity,
                        height: AppConstants.buttonHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                          child: Image.asset(
                            'lib/static/StudyNow.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spaceBetweenMainButtons),
                    
                    // Check Study Log Button - Using Image
                    GestureDetector(
                      onTap: () {
                        context.go('/study-log');
                      },
                      child: Container(
                        width: double.infinity,
                        height: AppConstants.buttonHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                          child: Image.asset(
                            'lib/static/StudyLog.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Spacer to push bottom buttons down
                const Spacer(),
                
                // Bottom Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Settings Button
                    _buildBottomButton(
                      context,
                      'SETTINGS',
                      Icons.settings,
                      () => context.go('/settings'),
                    ),
                    
                    // Help Button
                    _buildBottomButton(
                      context,
                      'HELP',
                      Icons.help_outline,
                      () => context.go('/help'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBottomButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        SizedBox(
          width: AppConstants.bottomButtonSize,
          height: AppConstants.bottomButtonSize,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.bottomButtonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}