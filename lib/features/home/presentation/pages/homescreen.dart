import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  final String username;
  final int numberOfWaves;

  const HomeScreen({Key? key, required this.username, this.numberOfWaves = 5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Hey $username',
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        // Wrapping the canvas in a scroll view
        child: CustomPaint(
          size: Size(400, 800), // Set the size of the canvas, make it taller to test scrolling
          painter: SineWaveCanvas(numberOfWaves: numberOfWaves), // Pass the number of waves
        ),
      ),
    );
  }
}

class SineWaveCanvas extends CustomPainter {
  final int numberOfWaves; // Number of full waves
  final double amplitude = 80.0; // Amplitude of the wave
  final double frequency = 0.5; // Decreased frequency for wider waves
  final double verticalShift = 200.0; // Vertical shift of the sine wave

  SineWaveCanvas({required this.numberOfWaves});

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..color = const Color.fromARGB(255, 132, 111, 150).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Paint nodePaint = Paint()
      ..color = const Color.fromARGB(255, 132, 111, 150).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    Path path = Path();
    double width = size.width;
    double height = size.height;

    // Calculate the number of points needed for the desired number of waves
    double pointsPerWave = height / numberOfWaves;

    // Loop through the vertical height (Y axis) to create vertical sine wave effect
    for (double y = 0; y < height; y++) {
      // Adjust the sine function to create the desired number of waves within the height
      double x = amplitude * sin((frequency * 2 * pi * y) / pointsPerWave) + width / 2;

      // The y-position is constant, and the x-position oscillates horizontally
      double xPos = x; // Horizontal position (left to right based on sine function)
      double yPos = y; // Vertical position (moves vertically downwards)

      if (y == 0) {
        path.moveTo(xPos, yPos);
      } else {
        path.lineTo(xPos, yPos);
      }

      // Place circular nodes at peaks and valleys (every half wave in vertical movement)
      if (y % (height / numberOfWaves / 2) == 0 && y != 0) {
        canvas.drawCircle(Offset(xPos, yPos), 20, nodePaint);
      }
    }

    // Draw the sine wave path
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
