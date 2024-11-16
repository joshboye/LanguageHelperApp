import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  final String username;
  final int numberOfWaves;
  final int numberOfNodes;

  const HomeScreen({Key? key, required this.username, this.numberOfWaves = 5, this.numberOfNodes = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final waveAmplitudes = List.generate(
      numberOfWaves,
      (_) => 80.0 + Random().nextDouble() * 80 - 40,
    );

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
        child: SizedBox(
          height: 1000, // Adjust height as needed
          child: Stack(
            children: [
              CustomPaint(
                size: const Size(double.infinity, 1000),
                painter: SineWaveCanvas(
                  numberOfWaves: numberOfWaves,
                  amplitudes: waveAmplitudes,
                ),
              ),
              NodeButtonsOverlay(
                numberOfWaves: numberOfWaves,
                numberOfNodes: numberOfNodes,
                canvasHeight: 1000,
                amplitudes: waveAmplitudes,
                labels: const [
                  "Adverb",
                  "Adjective",
                  "Conjunction",
                  "Prepositions",
                  "Tenses",
                  "Nouns",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class NodeButtonsOverlay extends StatelessWidget {
  final int numberOfWaves;
  final int numberOfNodes;
  final double canvasHeight;
  final List<double> amplitudes;
  final List<String> labels;
  final double frequency = 0.5;

  NodeButtonsOverlay({
    Key? key,
    required this.numberOfWaves,
    required this.numberOfNodes,
    required this.canvasHeight,
    required this.amplitudes,
    required this.labels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double waveSegmentHeight = canvasHeight / numberOfWaves;
    double nodeSpacing = canvasHeight / (numberOfNodes + 1);

    return Stack(
      children: [
        for (int i = 1; i <= numberOfNodes; i++) ...{
          Positioned(
            top: nodeSpacing * i - 20, // Adjust by half the button size
            left: _calculateNodePosition(nodeSpacing * i, waveSegmentHeight, width) - 20, // Adjust by half the button size
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped node $i: ${labels[i - 1]}')),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 132, 111, 150).withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  labels[i - 1],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        }
      ],
    );
  }

  double _calculateNodePosition(double y, double waveSegmentHeight, double width) {
    int waveIndex = (y ~/ waveSegmentHeight).clamp(0, numberOfWaves - 1);
    double amplitude = amplitudes[waveIndex];
    return amplitude * sin((frequency * 2 * pi * y) / waveSegmentHeight) + width / 2;
  }
}
