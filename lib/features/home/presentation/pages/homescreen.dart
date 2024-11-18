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
    this.username = '',
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
    waveAmplitude = List.generate(widget.numberOfWaves, (_) => 80.0 + Random().nextDouble() * 80 - 40);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      await provider.fetchLabels();
      provider.initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final sheetProvider = Provider.of<SheetProvider>(context);
    final nodeProvider = Provider.of<NodeProvider>(context);
    nodeProvider.setUserName(widget.username);

    // Use default labels when homeProvider.labels is empty
    final labels = homeProvider.labels.map((label) => label.name).toList();

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
                  // Only show NodeButtonsOverlay when we have valid labels
                  if (labels.isNotEmpty)
                    NodeButtonsOverlay(
                      numberOfWaves: widget.numberOfWaves,
                      numberOfNodes: widget.numberOfNodes,
                      canvasHeight: 1000,
                      amplitudes: waveAmplitude,
                      labels: labels,
                      onNodeTapped: (index) {
                        sheetProvider.setNodeIndex(index);
                        nodeProvider.setNodeIndex(index);
                        print('node index is $index');
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return SheetScreen(parentContext: context);
                          },
                        ).whenComplete(() {
                          sheetProvider.setNodeIndex(null);
                        });
                      },
                    ),
                  // Show loading indicator if data is being fetched
                  if (homeProvider.isLoading) const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
          if (sheetProvider.nodeIndex != null)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
        ],
      ),
    );
  }
}
