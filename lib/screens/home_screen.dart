import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../shared/providers/app_state.dart';
import '../core/constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
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
          
          SafeArea(
            child: _buildClickableAreas(context),
          ),
          
          Positioned(
            top: 60,
            right: 20,
            child: SizedBox(
              width: 120,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/device-pairing'),
                icon: const Icon(Icons.bluetooth, size: 18),
                label: const Text('Pairing'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.bluetoothButtonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
        // DIMENSION CALCULATION - Uses ratios from AppConstants
        // To adjust button positions: modify ratios in app_constants.dart
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        
        // Main button dimensions
        double buttonWidth = screenWidth * AppConstants.mainButtonWidthRatio;
        double buttonHeight = screenHeight * AppConstants.mainButtonHeightRatio;
        double horizontalPadding = screenWidth * AppConstants.horizontalPaddingRatio;
        
        // Button positions - adjust ratios in AppConstants to move buttons
        double studyNowTop = screenHeight * AppConstants.studyNowTopRatio;
        double studyLogTop = screenHeight * AppConstants.studyLogTopRatio;
        double bluetoothButtonTop = screenHeight * AppConstants.bluetoothButtonTopRatio;
        double bluetoothButtonWidth = screenWidth * AppConstants.bluetoothButtonWidthRatio;
        double bluetoothButtonHeight = screenHeight * AppConstants.bluetoothButtonHeightRatio;
        double bottomButtonsTop = screenHeight * AppConstants.bottomButtonsTopRatio;
        double bottomButtonWidth = screenWidth * AppConstants.bottomButtonWidthRatio;
        double bottomButtonHeight = screenHeight * AppConstants.bottomButtonHeightRatio;
        
        return Stack(
          children: [
            // STUDY NOW BUTTON - Position: studyNowTopRatio from top
            Positioned(
              top: studyNowTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: Semantics(
                label: 'Start Study Session',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/study'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // STUDY LOG BUTTON - Position: studyLogTopRatio from top
            Positioned(
              top: studyLogTop,
              left: horizontalPadding,
              width: buttonWidth,
              height: buttonHeight,
              child: Semantics(
                label: 'View Study Log',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/study-log'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // BLUETOOTH BUTTON - Position: bluetoothButtonTopRatio from top, centered
            Positioned(
              top: bluetoothButtonTop,
              left: (screenWidth - bluetoothButtonWidth) / 2,
              width: bluetoothButtonWidth,
              height: bluetoothButtonHeight,
              child: Semantics(
                label: 'Pair Device',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/device-pairing'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // SETTINGS BUTTON - Position: bottomButtonsTopRatio from top, left side
            Positioned(
              top: bottomButtonsTop,
              left: screenWidth * AppConstants.bottomButtonMarginRatio,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: Semantics(
                label: 'Settings',
                button: true,
                child: GestureDetector(
                  onTap: () => context.go('/settings'),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            
            // HELP BUTTON - Position: bottomButtonsTopRatio from top, right side
            Positioned(
              top: bottomButtonsTop,
              right: screenWidth * AppConstants.bottomButtonMarginRatio,
              width: bottomButtonWidth,
              height: bottomButtonHeight,
              child: Semantics(
                label: 'Help & Support',
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