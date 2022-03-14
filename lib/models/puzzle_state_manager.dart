import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';

class PuzzleStateManager extends ChangeNotifier {
  bool? _darkMode = false;
  final List _menuItems = ['Simple', 'Custom'];
  int? _currentMenuIndex = 0;

  bool get darkMode => _darkMode!;

  set darkMode(bool darkMode) {
    print('mode $darkMode');
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
