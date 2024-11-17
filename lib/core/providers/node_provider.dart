import 'package:flutter/material.dart';

class NodeProvider with ChangeNotifier {
  int? _nodeIndex; // The node index that was tapped
  int? _selectedExceriseIndex; // The selected button index

  int? get nodeIndex => _nodeIndex;
  int? get selectedExcerciseIndex => _selectedExceriseIndex;

  void setNodeIndex(int? index) {
    _nodeIndex = index;
    notifyListeners(); // Notify listeners when the index is updated
  }

  void selectedExceriseButton(int index) {
    if (_selectedExceriseIndex == index) {
      _selectedExceriseIndex = null;
    } else {
      _selectedExceriseIndex = index;
      print('excer index $index');
    }
    notifyListeners(); // Notify listeners when the selected button changes
  }
}
