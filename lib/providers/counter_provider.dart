import 'package:flutter/cupertino.dart';

class CounterStrike with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void setCount(int count) {
    _count = count;
    notifyListeners();
  }

  void increase() {
    _count++;
    print(_count);
    notifyListeners();
  }

  // void s
}
