// Class to Define Ball Properties
import 'dart:math';

import 'package:flutter/material.dart';

class Ball {
  final double radius;
  final Color color;
  double dx, dy;
  double speedX, speedY;

  Ball()
      : radius = Random().nextDouble() * 40 +
            20, // Bigger balls with radius between 30 and 80

        color = const Color.fromARGB(255, 156, 255, 0), // Fixed color
        dx = Random().nextDouble() * 500,
        dy = Random().nextDouble() * 500,
        speedX = Random().nextDouble() * 2, // Random X speed
        speedY = Random().nextDouble() * 2; // Random Y speed
}

// Painter for Animated Background
class AnimatedBackgroundPainter extends CustomPainter {
  final List<Ball> balls;
  final double animationValue;

  AnimatedBackgroundPainter(
      {required this.balls, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final ball in balls) {
      // Update ball positions
      ball.dx += ball.speedX * 3;
      ball.dy += ball.speedY * 3;

      // Check for boundaries and reverse direction
      if (ball.dx - ball.radius < 0 || ball.dx + ball.radius > size.width) {
        ball.speedX = -ball.speedX;
      }
      if (ball.dy - ball.radius < 0 || ball.dy + ball.radius > size.height) {
        ball.speedY = -ball.speedY;
      }

      // Draw the ball
      paint.color = ball.color.withOpacity(0.6);
      canvas.drawCircle(Offset(ball.dx, ball.dy), ball.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
