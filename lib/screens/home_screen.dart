import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../shared/providers/app_state.dart';
import '../core/constants/app_constants.dart';

/// Home screen with image-based navigation and invisible clickable areas.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Track user engagement by incrementing visit count after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().incrementVisit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppConstants.homePageImage,
              fit: BoxFit.cover,
            ),
          ),
          
          // Invisible clickable areas positioned over visual buttons
          SafeArea(
            child: _buildClickableAreas(context),
          ),
        ],
      ),
      // Temporary floating button to test loading screen
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/loading'),
        backgroundColor: AppConstants.primaryButtonColor,
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }

  Widget _buildClickableAreas(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions based on screen size
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        
        // Responsive button dimensions using constants
        double buttonWidth = screenWidth * AppConstants.mainButtonWidthRatio;
        double buttonHeight = screenHeight * AppConstants.mainButtonHeightRatio;
        double horizontalPadding = screenWidth * AppConstants.horizontalPaddingRatio;
        
        // Button positions using constants
        double studyNowTop = screenHeight * AppConstants.studyNowTopRatio;
        double studyLogTop = screenHeight * AppConstants.studyLogTopRatio;
        double bottomButtonsTop = screenHeight * AppConstants.bottomButtonsTopRatio;
        double bottomButtonWidth = screenWidth * AppConstants.bottomButtonWidthRatio;
        double bottomButtonHeight = screenHeight * AppConstants.bottomButtonHeightRatio;
        
        return Stack(
          children: [
            // Study Now button - accessible invisible overlay
            Positioned(
              top: studyNowTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: Semantics(
                label: 'Start Study Session',
                hint: 'Navigate to the study screen to begin a new study session',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/study'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // Study Log button - accessible invisible overlay  
            Positioned(
              top: studyLogTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: Semantics(
                label: 'View Study Log',
                hint: 'Navigate to the study log to review your study history and progress',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/study-log'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // Settings button - accessible invisible overlay
            Positioned(
              top: bottomButtonsTop,
              left: screenWidth * AppConstants.bottomButtonMarginRatio,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: Semantics(
                label: 'Settings',
                hint: 'Navigate to settings to manage your preferences and app data',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/settings'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // Help button - accessible invisible overlay
            Positioned(
              top: bottomButtonsTop,
              right: screenWidth * AppConstants.bottomButtonMarginRatio,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: Semantics(
                label: 'Help & Support',
                hint: 'Navigate to help section for guidance and troubleshooting',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/help'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}