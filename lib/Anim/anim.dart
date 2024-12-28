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
  late AnimationController _popcornController;
  late AnimationController _textController;
  late Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    // Animated gradient background
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = ColorTween(
      begin: const Color.fromARGB(255, 234, 149, 245),
      end: const Color.fromARGB(108, 35, 207, 255),
    ).animate(_backgroundController);

    // Popcorn bounce and spin animation
    _popcornController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    // Typewriter effect for the text
    _textController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    // Transition to the next screen
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NextScreen()),
      );
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _popcornController.dispose();
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
              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Typewriter effect for "Welcome to"
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        int charCount = (_textController.value * 10).toInt();
                        String text = "Welcome to".substring(
                            0, charCount.clamp(0, "Welcome to".length));
                        return Text(
                          text,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    // Bouncing and spinning popcorn
                    AnimatedBuilder(
                      animation: _popcornController,
                      child: const Text(
                        "🍿",
                        style: TextStyle(fontSize: 50),
                      ),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _popcornController.value * 2 * pi,
                          child: Transform.translate(
                            offset: Offset(
                                0, sin(_popcornController.value * pi) * 20),
                            child: child,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Text with glowing effect
                    const Text(
                      "UsePopcorn🍿",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.yellowAccent,
                            offset: Offset(0, 0),
                          ),
                        ],
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
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 2;

    for (int i = 0; i < 100; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(dx, dy), random.nextDouble() * 3, paint);
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
