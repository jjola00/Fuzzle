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
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              // Top spacing
              const SizedBox(height: 60),
              
              // Fuzzle Logo Section
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cat character (using emoji for simplicity)
                    Text(
                      '🐱',
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(width: 12),
                    Text(
                      AppConstants.appName,
                      style: TextStyle(
                        fontSize: AppConstants.logoFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.spaceBetweenSections),
              
              // Main Action Buttons
              Column(
                children: [
                  // Study Now Button
                  SizedBox(
                    width: double.infinity,
                    height: AppConstants.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/study');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryButtonColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'STUDY NOW',
                            style: TextStyle(
                              fontSize: AppConstants.buttonFontSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('🏆', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spaceBetweenMainButtons),
                  
                  // Check Study Log Button
                  SizedBox(
                    width: double.infinity,
                    height: AppConstants.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/study-log');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.secondaryButtonColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CHECK STUDY LOG',
                            style: TextStyle(
                              fontSize: AppConstants.buttonFontSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('📋', style: TextStyle(fontSize: 24)),
                        ],
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