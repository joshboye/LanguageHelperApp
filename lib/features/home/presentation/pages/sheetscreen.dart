import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/core/providers/node_provider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/homeprovider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/sheetprovider.dart';
import 'package:stimuler_task_app/routes.dart';

class SheetScreen extends StatefulWidget {
  final BuildContext parentContext;

  const SheetScreen({Key? key, required this.parentContext}) : super(key: key);

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

class _SheetScreenState extends State<SheetScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sheetProvider = Provider.of<SheetProvider>(widget.parentContext, listen: false);
      final nodeProvider = Provider.of<NodeProvider>(context, listen: false);
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      // Wait for data to load
      await sheetProvider.loadNodesData(homeProvider);
      sheetProvider.getCurrentNodeIndex(nodeProvider.nodeIndex);
    });
  }

  @override
  void didPopNext() {
    super.didPopNext();
    print('reubilt');
    setState(() {
      print('rebuilt yay');
    });
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(widget.parentContext);
    final nodeProvider = Provider.of<NodeProvider>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 35, 9, 48),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Exercise',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: sheetProvider.nodeToExerciseMap[sheetProvider.currentNodeIndex]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final exerciseScore = sheetProvider.getExerciseScore(index);
                    final isSelected = sheetProvider.selectedExcersiseIndex == index;
                    final hasScore = exerciseScore != null;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          sheetProvider.selectButton(index); // Update selected button
                          nodeProvider.selectedExceriseButton(index); // Notify node provider
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 90),
                          backgroundColor: isSelected ? (hasScore ? Colors.green : Colors.purple[300]) : const Color.fromARGB(255, 35, 9, 48),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: hasScore ? Colors.green : const Color.fromARGB(255, 221, 154, 255),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage('assets/images/books.jpg'),
                              radius: 30,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Exercise ${index + 1}', // Dynamic exercise label
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            const Spacer(),
                            if (hasScore) // Only show the score if it's not null
                              Text(
                                'Score: $exerciseScore',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isSelected
                                      ? Colors.white // If button is selected, make the text white
                                      : (hasScore ? Colors.green : const Color.fromARGB(179, 233, 226, 226)), // If score exists and button is not selected, make it green
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: sheetProvider.selectedExcersiseIndex != null
                    ? () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.quiz,
                          arguments: {
                            'nodeIndex': sheetProvider.nodeIndex,
                            'selectedButtonIndex': sheetProvider.selectedExcersiseIndex,
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ).copyWith(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.disabled)) {
                        return const Color.fromARGB(255, 112, 100, 113); // Disabled state color
                      }
                      return const Color.fromARGB(255, 207, 64, 233); // Enabled state color
                    },
                  ),
                ),
                child: const Text(
                  'Start Practice',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
