import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/homeprovider.dart';

class NodeButtonsOverlay extends StatelessWidget {
  final int numberOfWaves;
  final int numberOfNodes;
  final double canvasHeight;
  final List<double> amplitudes;
  final List<String> labels;
  final double frequency;
  final void Function(int index) onNodeTapped;

  const NodeButtonsOverlay({
    Key? key,
    required this.numberOfWaves,
    required this.numberOfNodes,
    required this.canvasHeight,
    required this.amplitudes,
    required this.labels,
    required this.onNodeTapped,
    this.frequency = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty || labels.length < numberOfNodes) {
      return const SizedBox.shrink();
    }

    final provider = Provider.of<HomeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double waveSegmentHeight = canvasHeight / numberOfWaves;
    double nodeSpacing = canvasHeight / (numberOfNodes + 1);

    return Stack(
      children: [
        for (int i = 1; i <= numberOfNodes; i++) ...{
          Positioned(
            top: nodeSpacing * i - 20,
            left: _calculateNodePosition(nodeSpacing * i, waveSegmentHeight, width) - 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (provider.nodeProgress[i - 1] == 1) {
                      onNodeTapped(i);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: provider.nodeProgress[i - 1] == 1
                              ? Colors.green.withOpacity(0.8) // Green for completed node
                              : Colors.grey.withOpacity(0.8), // Default color
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
