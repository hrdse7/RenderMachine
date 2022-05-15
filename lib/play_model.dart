import 'dart:async';
import 'package:flutter/material.dart';

class TenStopWatchModel extends ChangeNotifier {
  bool isStartPressed = true;
  bool isStopPressed = true;
  bool isResetPressed = true;

  String tenStopWatchTimeDisplay = '10:00';
  //Stopwatch class
  var tenSwatch = Stopwatch();
  //Duration class
  final dul = const Duration(milliseconds: 0);

  //10秒後TimeUp表示
  bool isShow = false;
  //ボタンを非表示
  bool isHide = true;

  //dart:asyncライブラリで定義されるTimerクラス
  startTimer() {
    Timer(dul, keepRunning);

    //10秒で止める
    if (tenSwatch.elapsed.inSeconds == 10) {
      tenSwatch.stop();
      isShow = !isShow; //TimeUpと表示
      isHide = !isHide; //ボタンを非表示
    }
  }

  keepRunning() {
    if (tenSwatch.isRunning) {
      startTimer();
    }
    //ミリ秒
    int milliSeconds = ((tenSwatch.elapsedMilliseconds / 10).floor() % 100);

    //秒、ミリ秒
    tenStopWatchTimeDisplay =
        (tenSwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
            ':' +
            (milliSeconds).toString().padLeft(2, '0');

    // 変更があったことを通知する。（何秒経過したか）
    notifyListeners();
  }

  startStopWatch() {
    isStartPressed = true;
    tenSwatch.start();
    startTimer();
    notifyListeners();
  }

  stopStopWatch() {
    this.isStopPressed = true;
    this.isResetPressed = false;
    tenSwatch.stop();
    notifyListeners();
  }
}

class SixtyStopWatchModel extends ChangeNotifier {
  bool isStartPressed = true;
  bool isStopPressed = true;
  bool isResetPressed = true;

  String sixtyStopWatchTimeDisplay = '60:00';
  //Stopwatch class
  var sixtySwatch = Stopwatch();
  //Duration class
  final dul = const Duration(milliseconds: 0);

  //60秒後TimeUp表示
  bool isShow = false;
  //ボタンを非表示
  bool isHide = true;

  //dart:asyncライブラリで定義されるTimerクラス
  startTimer() {
    Timer(dul, keepRunning);

    //60秒で止める
    if (sixtySwatch.elapsed.inSeconds == 60) {
      sixtySwatch.stop();
      isShow = !isShow; //TimeUpと表示
      isHide = !isHide; //ボタンを非表示
    }
  }

  keepRunning() {
    if (sixtySwatch.isRunning) {
      startTimer();
    }

    //ミリ秒
    int milliSeconds = ((sixtySwatch.elapsedMilliseconds / 10).floor() % 100);

    //秒、ミリ秒 (%61にすると終了時60:00と表示される)
    sixtyStopWatchTimeDisplay =
        (sixtySwatch.elapsed.inSeconds % 61).toString().padLeft(2, '0') +
            ':' +
            (milliSeconds).toString().padLeft(2, '0');

    // 変更があったことを通知する。（何秒経過したか）
    notifyListeners();
  }

  startStopWatch() {
    // this.isStopPressed = false;
    isStartPressed = true;
    sixtySwatch.start();
    startTimer();
    notifyListeners();
  }

  stopStopWatch() {
    this.isStopPressed = true;
    this.isResetPressed = false;
    sixtySwatch.stop();
    notifyListeners();
  }
}
