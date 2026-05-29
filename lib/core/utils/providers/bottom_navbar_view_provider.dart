

import 'package:flutter/material.dart';

class BottomNavBarViewProvider with ChangeNotifier {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void setVisible(bool value){
    _isVisible = value;
    notifyListeners();
  } 
}