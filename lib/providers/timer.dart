import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linguaotter/pages/home_screen.dart';

class TimerCount with ChangeNotifier {

  late Timer _timer;
  late int _start;
  late int _restart;

  int get getTime => _start;

  void setTime(restart)
  {
    _start = restart;
  }

  void setResetTime()
  {
    _restart = _start;
  }

  void resetTime()
  {
    _start = _restart;
  }

  void cancelTime()
  {
    _timer.cancel();
  }

  void startTimer({required BuildContext context, required String mode, required int score, required int setTimeSecond}) {
    setTime(setTimeSecond);
    setResetTime();
    const oneSec =  Duration(seconds: 1);

    _timer =   Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          cancelTime();
            Navigator.pushReplacementNamed(context, "/congrats", arguments: {
              "mode": mode,
              "score": score,
            });

            notifyListeners();

        } else {
            _start--;
            notifyListeners();
        }
      },
    );
  }

}
