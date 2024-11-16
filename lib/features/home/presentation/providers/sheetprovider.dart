import 'package:flutter/material.dart';

class SheetProvider with ChangeNotifier {
  int? _nodeIndex; // The node index that was tapped
  int? _selectedButtonIndex; // The selected button index

  int? get nodeIndex => _nodeIndex;
  int? get selectedButtonIndex => _selectedButtonIndex;

  void setNodeIndex(int? index) {
    _nodeIndex = index;
    notifyListeners(); // Notify listeners when the index is updated
  }

  void selectButton(int index) {
    if (_selectedButtonIndex == index) {
      _selectedButtonIndex = null;
    } else {
      _selectedButtonIndex = index;
    }
    notifyListeners(); // Notify listeners when the selected button changes
  }
}
