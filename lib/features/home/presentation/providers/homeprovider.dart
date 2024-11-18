import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';
import 'package:stimuler_task_app/features/home/domain/usecases/get_labels_usecase.dart';

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
        _nodeProgress[0] = 1.0;
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

  void tapNode(int index) {
    if (_nodeProgress[index] == 1 && index < _nodeProgress.length - 1) {
      _nodeProgress[index + 1] = 1; // Enable the next node
    }
    notifyListeners();
  }
}
