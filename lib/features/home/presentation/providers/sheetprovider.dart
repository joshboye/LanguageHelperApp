import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/exercises.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';

class SheetProvider with ChangeNotifier {
  int? _nodeIndex; // The node index that was tapped
  int? _selectedExcersiseIndex; // The selected button index
  int? _excersiseScore1;
  int? _excersiseScore2;
  int _currentNodeIndex = 0;

  int? get nodeIndex => _nodeIndex;
  int get currentNodeIndex => _currentNodeIndex;
  int? get selectedExcersiseIndex => _selectedExcersiseIndex;
  int? get excersiseScore1 => _excersiseScore1;
  int? get excersiseScore2 => _excersiseScore2;

  void setNodeIndex(int? index) {
    _nodeIndex = index;
    notifyListeners(); // Notify listeners when the index is updated
  }

  void getCurrentNodeIndex(int index) {
    _currentNodeIndex = index - 1;
    notifyListeners();
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
  List<Exercise> exercises = [];
  int exerciseLength = 0;

  Future<void> loadNodesData() async {
    final nodeBox = await Hive.openBox<Node>('nodesBox');
    var exerciseBox = await Hive.openBox<Exercise>('exercisesBox');
    exercises = exerciseBox.values.toList(); //this has all the excersise scores.
    exerciseLength = exercises.length; // score

    nodes = nodeBox.values.toList();
    var exceriseslengt = nodes[0].exercises.length; //this has excersise length
    print('excersise length is ${exceriseslengt}');
    notifyListeners();
  }

  // Node-to-exercise mapping
  final Map<int, List<int>> _nodeToExerciseMap = {
    0: [
      3,
      9,
      7
    ],
    1: [
      0,
      2
    ],
    2: [
      4,
      13
    ],
    3: [
      11,
      1
    ],
    4: [
      5,
      8
    ],
    5: [
      10,
      6,
      12
    ],
  };

  // Getter for nodeToExerciseMap
  Map<int, List<int>> get nodeToExerciseMap => _nodeToExerciseMap;

  // Load the score for a specific exercise
  int? getExerciseScore(int exerciseIndex) {
    if (_currentNodeIndex >= 0 && _currentNodeIndex < _nodeToExerciseMap.length) {
      final exerciseIndices = _nodeToExerciseMap[_currentNodeIndex];
      if (exerciseIndex >= 0 && exerciseIndex < exerciseIndices!.length) {
        final actualExerciseIndex = exerciseIndices[exerciseIndex];
        return exercises[actualExerciseIndex].score;
      }
    }
    return null; // Return null if indices are invalid
  }
}
