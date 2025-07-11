import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../shared/providers/app_state.dart';

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
              'lib/static/homePage.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Invisible clickable areas positioned over visual buttons
          SafeArea(
            child: _buildClickableAreas(context),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableAreas(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions based on screen size
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        
        // Responsive button dimensions based on screen size
        double buttonWidth = screenWidth * 0.8;
        double buttonHeight = screenHeight * 0.08;
        double horizontalPadding = screenWidth * 0.1;
        
        double studyNowTop = screenHeight * 0.38;
        double studyLogTop = screenHeight * 0.51;
        double bottomButtonsTop = screenHeight * 0.85;
        double bottomButtonWidth = screenWidth * 0.4;
        double bottomButtonHeight = screenHeight * 0.10;
        
        return Stack(
          children: [
            Positioned(
              top: studyNowTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: GestureDetector(
                onTap: () => context.go('/study'),
                child: Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            
            // Study Log button - secondary action for progress tracking
            Positioned(
              top: studyLogTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: GestureDetector(
                onTap: () => context.go('/study-log'),
                child: Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            
            // Settings button - left side of bottom row
            Positioned(
              top: bottomButtonsTop,
              left: screenWidth * 0.05,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: GestureDetector(
                onTap: () => context.go('/settings'),
                child: Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            
            // Help button - right side of bottom row
            Positioned(
              top: bottomButtonsTop,
              right: screenWidth * 0.05,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: GestureDetector(
                onTap: () => context.go('/help'),
                child: Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.transparent),
                    ),
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