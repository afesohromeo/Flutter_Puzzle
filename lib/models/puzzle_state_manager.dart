

import 'package:flutter/material.dart';
import 'dart:developer';

class PuzzleStateManager extends ChangeNotifier {
  bool? _darkMode = false;
  final List _menuItems = ['Simple', 'Custom'];
  int? _currentMenuIndex = 0;

  bool get darkMode => _darkMode!;

  set darkMode(bool darkMode) {
    log('mode $darkMode');
    _darkMode = darkMode;

    notifyListeners();
  }

  List get menuItems => _menuItems;

  int get currentMenuIndex => _currentMenuIndex!;
  set currentMenuIndex(int currentMenuIndex) {
    _currentMenuIndex = currentMenuIndex;

    notifyListeners();
  }

  String get assetName => _darkMode!
      ? 'assets/images/logo_flutter_white.png'
      : 'assets/images/logo_flutter_color.png';

  void rebuild() {
    notifyListeners();
  }
}
