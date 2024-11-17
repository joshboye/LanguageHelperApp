import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';

class SheetProvider with ChangeNotifier {
  int? _nodeIndex; // The node index that was tapped
  int? _selectedExcersiseIndex; // The selected button index
  int? _excersiseScore1;
  int? _excersiseScore2;

  int? get nodeIndex => _nodeIndex;
  int? get selectedExcersiseIndex => _selectedExcersiseIndex;
  int? get excersiseScore1 => _excersiseScore1;
  int? get excersiseScore2 => _excersiseScore2;

  void setNodeIndex(int? index) {
    _nodeIndex = index;
    notifyListeners(); // Notify listeners when the index is updated
  }

  void selectButton(int index) {
    if (_selectedExcersiseIndex == index) {
      _selectedExcersiseIndex = null;
    } else {
      _selectedExcersiseIndex = index;
    }
    notifyListeners(); // Notify listeners when the selected button changes
  }

  List<Node> nodes = [];

  Future<void> loadNodesData() async {
    final nodeBox = await Hive.openBox<Node>('nodesBox');
    nodes = nodeBox.values.toList();
    print('nodes length is ${nodes.length}');
    notifyListeners();
  }

  // Load the score for a specific exercise
  int? getExerciseScore(int nodeIndex, int exerciseIndex) {
    if (nodeIndex < nodes.length && exerciseIndex < nodes[nodeIndex].exercises.length) {
      print('here ');
      return nodes[nodeIndex].exercises[exerciseIndex].score;
    }
    return null; // Return null if indices are invalid
  }
}
