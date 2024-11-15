import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  final int nodeCount = 10; // Reduced the number of nodes for less frequency
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Hey $username',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: RepaintBoundary(
          child: SizedBox(
            height: (nodeCount - 1) * 160.0 + 100.0, // Adjusted height for the new distance and added margin for padding
            child: CustomPaint(
              size: Size(screenWidth, (nodeCount - 1) * 160.0 + 100.0), // Adjust size accordingly
              painter: VerticalSplineChartWithNodesPainter(nodeCount: nodeCount),
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalSplineChartWithNodesPainter extends CustomPainter {
  final int nodeCount;
  VerticalSplineChartWithNodesPainter({required this.nodeCount});

  @override
  void paint(Canvas canvas, Size size) {
    const distance = 160.0; // Increased distance between peaks and valleys for less frequency
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8 // Thicker spline
      ..style = PaintingStyle.stroke;

    final path = Path();
    final random = Random();
    double xCenter = size.width / 2;

    // List to store points for nodes
    List<Offset> nodePoints = [];

    // Start at the top center
    path.moveTo(xCenter, 0);

    for (int i = 0; i < nodeCount; i++) {
      double y = i * distance; // Calculate y position

      // Randomly decide the peak or valley position
      double randomOffset = random.nextDouble() * size.width / 3;
      double x = random.nextBool() ? xCenter + randomOffset : xCenter - randomOffset;

      // Add the curve
      if (i > 0) {
        path.quadraticBezierTo(xCenter, y - distance / 2, x, y);
      }

      // Add the node point
      nodePoints.add(Offset(x, y));
    }

    // Draw the path
    canvas.drawPath(path, paint);

    // Draw nodes at each peak and valley with bigger size
    final nodePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (Offset point in nodePoints) {
      canvas.drawCircle(point, 20, nodePaint); // Larger circle for each node
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool hitTest(Offset position) => false;
}
