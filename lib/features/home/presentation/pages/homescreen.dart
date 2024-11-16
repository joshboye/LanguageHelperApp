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
  final double baseAmplitude = 80.0; // Base amplitude of the wave
  final double frequency = 0.5; // Decreased frequency for wider waves
  final Random random = Random();

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

    // Calculate the height of each wave segment
    double waveSegmentHeight = height / numberOfWaves;

    // Generate random amplitudes for each wave segment
    List<double> amplitudes = List.generate(numberOfWaves, (_) => baseAmplitude + random.nextDouble() * 80 - 40);

    // Loop through the vertical height to draw waves
    for (double y = 0; y < height; y++) {
      // Determine which wave segment we are in
      int waveIndex = (y ~/ waveSegmentHeight).clamp(0, numberOfWaves - 1);

      // Use the amplitude for the current wave segment
      double amplitude = amplitudes[waveIndex];

      // Adjust the sine function for the current wave segment
      double x = amplitude * sin((frequency * 2 * pi * y) / waveSegmentHeight) + width / 2;

      if (y == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Place circular nodes at peaks and valleys (every half wave in vertical movement)
      if (y % (waveSegmentHeight / 2) == 0 && y != 0) {
        canvas.drawCircle(Offset(x, y), 20, nodePaint);
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
