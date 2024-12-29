import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    // Background gradient animation
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = ColorTween(
      begin: const Color(0xFF141E30),
      end: const Color(0xFF243B55),
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    // Logo animation
    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    // Text fade-in animation
    _textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // Navigate to the next screen
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NextScreen()),
      );
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Animated gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _backgroundAnimation.value!,
                      _backgroundAnimation.value!.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Animated content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo animation
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1 + (_logoController.value * 0.2),
                          child: Opacity(
                            opacity: _logoController.value,
                            child: child,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.local_movies,
                        size: 100,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Text animation
                    FadeTransition(
                      opacity: _textController,
                      child: const Text(
                        "Welcome to UsePopcorn",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Circular progress indicator
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  ],
                ),
              ),
              // Sparkling particles
              Positioned.fill(
                child: CustomPaint(
                  painter: ParticlePainter(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Particle Effect
class ParticlePainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 1.5;

    for (int i = 0; i < 80; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(dx, dy), random.nextDouble() * 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Next Screen Placeholder
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the next screen!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
