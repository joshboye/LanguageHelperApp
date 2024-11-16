import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';
import 'package:stimuler_task_app/features/home/domain/usecases/get_labels_usecase.dart';

class HomeProvider with ChangeNotifier {
  final GetLabelsUseCase? getLabelsUseCase;

  List<Label> _labels = [];
  List<double> _nodeProgress = [];
  int _currentNode = 0;
  bool _isLoading = true; // Add loading state

  List<Label> get labels => _labels;
  List<double> get nodeProgress => _nodeProgress;
  bool get isLoading => _isLoading;

  HomeProvider({this.getLabelsUseCase});

  void initialize(BuildContext context) {
    // Using addPostFrameCallback to ensure this happens after the widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nodeProgress = [
        1,
        1,
        0.5,
        0,
        0,
        0
      ]; // Set the list with the provided custom values
      notifyListeners(); // Notify listeners after the frame is built
    });
  }

  Future<void> fetchLabels() async {
    try {
      _isLoading = true;
      notifyListeners();

      _labels = await getLabelsUseCase!();

      _labels.insert(0, Label("1"));

      _isLoading = false; // Update loading state
    } catch (e) {
      _isLoading = false;
    }

    notifyListeners();
  }

  void tapNode(int index) {
    if (_nodeProgress[index] == 1 && index < _nodeProgress.length - 1) {
      _nodeProgress[index + 1] = 1; // Enable the next node
    }

    notifyListeners();
  }
}
