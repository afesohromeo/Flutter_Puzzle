import 'dart:async';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:provider/provider.dart';

class TimerStateManager extends ChangeNotifier {
  bool? _timerStarted = false;
  bool? _shufflePuzzle = true;
  bool? _gettingReady = false;
  int? secondsElapsed = 0;
  final Stopwatch _stopwatch = Stopwatch();
  late final Ticker? _ticker;

  StreamSubscription<int>? _tickerSubscription;

  bool get timerStarted => _timerStarted!;
  bool get gettingReady => _gettingReady!;
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

  set gettingReady(bool gettingReady) {
    _gettingReady = gettingReady;
    notifyListeners();
  }

  void _onTimerStarted() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker!.tick().listen((secondsElapsed) => secondsElapsed);
    _timerStarted = true;
  }

  void handleStartStop() {
    print('handleing start stop');

    if (_stopwatch.isRunning) {
      print('stopinng');
      timerStarted = !_stopwatch.isRunning;
      _stopwatch.stop();
      _stopwatch.reset();

      notifyListeners();
    } else {
      print('starting');

      _gettingReady = _stopwatch.isRunning;

      _stopwatch.start();
      timerStarted = _stopwatch.isRunning;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        print('timer ticking ${timer.tick}');
        if (_stopwatch.isRunning) {
          notifyListeners();
        } else {
          timer.cancel();
        }
      });

      notifyListeners();
    }
  }

  void stopTimer() {
    timerStarted = !_stopwatch.isRunning;

    _stopwatch.stop();
    _stopwatch.reset();
  }

  void rebuild() {
    notifyListeners();
  }

  void getReady() {
    gettingReady = true;
    bool? done;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      print('tick ${timer.tick}, ${timer.tick == 3}');

      timer.tick == 4 || timer.tick > 5
          ? () {
              gettingReady = false;
              timer.cancel();

              notifyListeners();
            }()
          : () {
              null;
            }();
    });

    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tickerSubscription!.cancel();
  }
}
