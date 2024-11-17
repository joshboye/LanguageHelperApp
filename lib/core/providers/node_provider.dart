import 'package:flutter/material.dart';

class NodeProvider with ChangeNotifier {
  int _nodeIndex = 0; // The node index that was tapped
  int? _selectedExceriseIndex; // The selected button index
  String? _username;

  int get nodeIndex => _nodeIndex;
  int? get selectedExcerciseIndex => _selectedExceriseIndex;
  String? get username => _username;

  void setNodeIndex(int index) {
    _nodeIndex = index;
    print('from nodeprovider ${nodeIndex}');
    notifyListeners(); // Notify listeners when the index is updated
  }

  void setUserName(String username) {
    _username = username;
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
