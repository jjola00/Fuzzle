import 'dart:math';
import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

/// Loading screen matching the loadingPage.png design.
/// Features animated Fuzzle logo, loading cat above dots, and pulsing black dots.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _dotsController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize bounce animation for the Fuzzle logo
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Soft bounce animation using sine wave pattern
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 15,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
    
    // Initialize dots animation for loading indicator
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _dotsAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _dotsController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _bounceController.repeat(reverse: true);
    _dotsController.repeat();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with animated Fuzzle logo
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _bounceAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_bounceAnimation.value),
                        child: Image.asset(
                          AppConstants.fuzzleLogoImage,
                          width: 200,
                          height: 120,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback if logo image doesn't load
                            return Container(
                              width: 200,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.school,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40), // Space between logo and cat
                ],
              ),
            ),
            
            // Bottom section with loading cat and dots
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Loading cat - made bigger and positioned higher
                  Image.asset(
                    AppConstants.loadingCatImage,
                    width: 240,
                    height: 180,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if cat image doesn't load
                      return Container(
                        width: 240,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.pets,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Animated black dots
                  _buildLoadingDots(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates animated loading dots with wave effect - black colored
  Widget _buildLoadingDots() {
    return AnimatedBuilder(
      animation: _dotsAnimation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            // Calculate animation delay for each dot to create wave effect
            double animationDelay = index * 0.3;
            double animationValue = (_dotsAnimation.value - animationDelay).clamp(0.0, 1.0);
            
            // Create pulsing effect using sine wave
            double pulseValue = sin(animationValue * 2 * pi);
            double opacity = 0.3 + (pulseValue + 1) * 0.35; // Range: 0.3 to 1.0
            double scale = 0.8 + (pulseValue + 1) * 0.2; // Range: 0.8 to 1.2
            
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: opacity),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
} 