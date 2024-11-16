import 'package:flutter/material.dart';

class NodeProvider extends ChangeNotifier {
  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
