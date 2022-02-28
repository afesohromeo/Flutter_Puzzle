import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/model.dart';

class TimerStateManager extends ChangeNotifier {
  bool? _timerStarted = false;
  bool? _shufflePuzzle = true;
  bool? _timerPaused = false;
  int? secondsElapsed = 0;
  final Stopwatch _stopwatch = Stopwatch();
  late final Ticker? _ticker;

  StreamSubscription<int>? _tickerSubscription;

  bool get timerStarted => _timerStarted!;
  bool get timerPaused => _timerPaused!;
  bool get shufflePuzzle => _shufflePuzzle!;
  Stopwatch get stopwatch => _stopwatch;

  set timerStarted(bool timerStarted) {
    _timerStarted = timerStarted;
    notifyListeners();
  }

  set shufflePuzzle(bool shufflePuzzle) {
    _shufflePuzzle = shufflePuzzle;
    notifyListeners();
  }

  set timerPaused(bool timerPaused) {
    _timerPaused = timerPaused;
    notifyListeners();
  }

  void _onTimerStarted() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker!.tick().listen((secondsElapsed) => secondsElapsed);
    _timerStarted = true;
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      timerStarted = !_stopwatch.isRunning;
      _stopwatch.stop();
      _stopwatch.reset();
      

      notifyListeners();
    } else {

      _stopwatch.start();
      timerStarted = _stopwatch.isRunning;

      // Timer.periodic(const Duration(seconds: 1), (timer) {
      //   print(_stopwatch.elapsed.inSeconds);
      //   if (!_stopwatch.isRunning) {
      //     timer.cancel();
      //   }
      //   notifyListeners();
      // });
      notifyListeners();
    }
  }

  void rebuild() {
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tickerSubscription!.cancel();
  }
}
