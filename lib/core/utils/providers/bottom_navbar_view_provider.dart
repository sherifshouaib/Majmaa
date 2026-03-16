

import 'package:flutter/material.dart';

class BottomNavBarViewProvider with ChangeNotifier {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  setVisible(bool value){
    _isVisible = value;
    notifyListeners();
  } 
}