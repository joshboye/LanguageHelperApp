import 'dart:math';

import 'package:flutter/material.dart';

class SineWaveCanvas extends CustomPainter {
  final int numberOfWaves;
  final List<double> amplitudes;
  final double frequency = 0.5;

  SineWaveCanvas({required this.numberOfWaves, required this.amplitudes});

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..color = const Color.fromARGB(255, 132, 111, 150).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Path path = Path();
    double width = size.width;
    double height = size.height;
    double waveSegmentHeight = height / numberOfWaves;

    for (double y = 0; y < height; y++) {
      int waveIndex = (y ~/ waveSegmentHeight).clamp(0, numberOfWaves - 1);
      double amplitude = amplitudes[waveIndex];
      double x = amplitude * sin((frequency * 2 * pi * y) / waveSegmentHeight) + width / 2;

      if (y == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
