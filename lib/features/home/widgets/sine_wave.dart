import 'dart:math';

import 'package:flutter/material.dart';

class SineWaveCanvas extends CustomPainter {
  final int numberOfWaves;
  final List<double> amplitudes;
  final List<double> nodeProgress; // Add nodeProgress to customize the color
  final double frequency = 0.5;

  SineWaveCanvas({
    required this.numberOfWaves,
    required this.amplitudes,
    required this.nodeProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    double width = size.width;
    double height = size.height;
    double waveSegmentHeight = height / numberOfWaves;

    // Iterate over each horizontal segment of the canvas
    for (int waveIndex = 0; waveIndex < numberOfWaves; waveIndex++) {
      Path path = Path();
      double amplitude = amplitudes[waveIndex];
      double startY = waveIndex * waveSegmentHeight;
      double endY = startY + waveSegmentHeight;

      // Iterate over the vertical points of the wave (x-axis)
      for (double y = startY; y < endY; y++) {
        double x = amplitude * sin((frequency * 2 * pi * y) / waveSegmentHeight) + width / 2;

        // Set wave color based on node progress
        wavePaint.color = nodeProgress[waveIndex] == 1
            ? Colors.green.withOpacity(0.5) // Completed node
            : const Color.fromARGB(255, 132, 111, 150).withOpacity(0.5); // Default color

        // Move to the starting point of the path
        if (y == startY) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      // Draw the path for each wave segment
      canvas.drawPath(path, wavePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
