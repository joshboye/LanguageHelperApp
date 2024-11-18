import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';
import 'package:stimuler_task_app/features/home/domain/usecases/get_labels_usecase.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/sheetprovider.dart';

class HomeProvider with ChangeNotifier {
  final GetLabelsUseCase? getLabelsUseCase;

  List<Label> _labels = [];
  List<double> _nodeProgress = [];
  int _currentNode = 0;
  bool _isLoading = true;

  List<Label> get labels => _labels;
  List<double> get nodeProgress => _nodeProgress;
  bool get isLoading => _isLoading;

  HomeProvider({this.getLabelsUseCase});

  void initialize(BuildContext context) {
    try {
      // Initialize with the correct length
      if (_nodeProgress.isEmpty) {
        print('in here at hoem init');
        _nodeProgress = List.filled(6, 0.0);
        // Set initial progress values
        _nodeProgress[0] = 1;
      }

      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> fetchLabels() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (getLabelsUseCase != null) {
        _labels = await getLabelsUseCase!();
      }
    } catch (e) {
      print('Error fetching labels: $e');
      // Handle error appropriately
      _labels = []; // Ensure labels is empty but initialized
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateNodeProgress(int index, double progress) {
    // print('inside update nodeprogress');
    if (index < _nodeProgress.length) {
      _nodeProgress[index] = progress;
      notifyListeners(); // Notify listeners to reflect the progress change
      print(nodeProgress);
    }
  }

  void updateAllNodeProgress(SheetProvider sheetProvider, HomeProvider homeProvider) {
    for (int nodeIndex = 0; nodeIndex < sheetProvider.nodeToExerciseMap.length; nodeIndex++) {
      final exerciseIndices = sheetProvider.nodeToExerciseMap[nodeIndex];

      print('Checking progress for node index $nodeIndex');

      // Check if all exercise scores for the node are non-null
      bool allScoresFilled = true;
      for (var exerciseIndex in exerciseIndices!) {
        final exercise = sheetProvider.exercises[exerciseIndex];
        print('Score for exercise $exerciseIndex: ${exercise.score}');

        if (exercise.score == null) {
          allScoresFilled = false;
          break; // Stop checking if any score is null
        }
      }

      print('All scores filled for node $nodeIndex: $allScoresFilled');

      // Update progress for nodes
      if (nodeIndex == 0 && homeProvider.nodeProgress[0] == 1.0) {
        // Skip updating node 0 if it's already initialized to 1
        continue;
      }

      if (allScoresFilled && nodeIndex < homeProvider.nodeProgress.length) {
        print('All exercises completed for node $nodeIndex, updating progress');
        homeProvider.updateNodeProgress(nodeIndex, 1.0); // Update node progress to 1 (completed)
      } else if (!allScoresFilled && nodeIndex < homeProvider.nodeProgress.length) {
        print('Not all exercises completed for node $nodeIndex, no progress update');
        homeProvider.updateNodeProgress(nodeIndex, 0.0); // Set progress to 0 (incomplete)
      }
    }
  }

  void tapNode(int index) {
    if (_nodeProgress[index] == 1 && index < _nodeProgress.length - 1) {
      _nodeProgress[index + 1] = 1; // Enable the next node
    }
    notifyListeners();
  }
}
