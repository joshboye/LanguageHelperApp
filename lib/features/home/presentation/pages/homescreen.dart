import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/core/providers/node_provider.dart';
import 'package:stimuler_task_app/features/home/presentation/pages/sheetscreen.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/homeprovider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/sheetprovider.dart';
import 'package:stimuler_task_app/features/home/widgets/node_button_overlay.dart';
import 'package:stimuler_task_app/features/home/widgets/sine_wave.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final int numberOfWaves;
  final int numberOfNodes;

  const HomeScreen({
    Key? key,
    required this.username,
    this.numberOfWaves = 5,
    this.numberOfNodes = 6,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<double> waveAmplitude;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.fetchLabels();
    provider.initialize(context);

    waveAmplitude = List.generate(widget.numberOfWaves, (_) => 80.0 + Random().nextDouble() * 80 - 40);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final sheetProvider = Provider.of<SheetProvider>(context);
    final nodeProvider = Provider.of<NodeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Hey ${widget.username}',
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 1000,
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 1000),
                    painter: SineWaveCanvas(
                      numberOfWaves: widget.numberOfWaves,
                      amplitudes: waveAmplitude,
                    ),
                  ),
                  NodeButtonsOverlay(
                      numberOfWaves: widget.numberOfWaves,
                      numberOfNodes: widget.numberOfNodes,
                      canvasHeight: 1000,
                      amplitudes: waveAmplitude,
                      labels: homeProvider.labels.map((label) => label.name).toList(),
                      onNodeTapped: (index) {
                        sheetProvider.setNodeIndex(index);
                        nodeProvider.setNodeIndex(index);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // Enables control over the height
                          backgroundColor: Colors.transparent, // Makes the sheet background transparent
                          builder: (context) {
                            return SheetScreen(parentContext: context); // Pass the parent context
                          },
                        ).whenComplete(() {
                          sheetProvider.setNodeIndex(null); // Reset nodeIndex after sheet closes
                        });
                      }),
                ],
              ),
            ),
          ),
          if (sheetProvider.nodeIndex != null) // Apply blur only when the sheet is open
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.2), // Optional overlay color
              ),
            ),
        ],
      ),
    );
  }
}
