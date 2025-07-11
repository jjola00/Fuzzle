import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/static/homePage.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Clickable areas overlay
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
        
        // Calculate button dimensions and positions relative to screen size
        double buttonWidth = screenWidth * 0.8;
        double buttonHeight = screenHeight * 0.08;
        double horizontalPadding = screenWidth * 0.1;
        
        // Position calculations based on the image layout
        double studyNowTop = screenHeight * 0.35;
        double studyLogTop = screenHeight * 0.48;
        double bottomButtonsTop = screenHeight * 0.75;
        double bottomButtonWidth = screenWidth * 0.35;
        double bottomButtonHeight = screenHeight * 0.12;
        
        return Stack(
          children: [
            // Study Now Button (invisible clickable area)
            Positioned(
              top: studyNowTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: GestureDetector(
                onTap: () {
                  context.go('/study');
                },
                child: Container(
                  // Make it transparent but still clickable
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '', // Empty text - the image shows the button
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            
            // Check Study Log Button (invisible clickable area)
            Positioned(
              top: studyLogTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: GestureDetector(
                onTap: () {
                  context.go('/study-log');
                },
                child: Container(
                  // Make it transparent but still clickable
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '', // Empty text - the image shows the button
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            
            // Settings Button (invisible clickable area)
            Positioned(
              top: bottomButtonsTop,
              left: screenWidth * 0.1,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: GestureDetector(
                onTap: () {
                  context.go('/settings');
                },
                child: Container(
                  // Make it transparent but still clickable
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '', // Empty text - the image shows the button
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            
            // Help Button (invisible clickable area)
            Positioned(
              top: bottomButtonsTop,
              right: screenWidth * 0.1,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: GestureDetector(
                onTap: () {
                  context.go('/help');
                },
                child: Container(
                  // Make it transparent but still clickable
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      '', // Empty text - the image shows the button
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