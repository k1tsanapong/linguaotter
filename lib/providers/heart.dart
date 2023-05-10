import 'package:flutter/cupertino.dart';

class Heart with ChangeNotifier {
  int _heart = 0;

  int get getHeart => _heart;

  void startHeart(int heart){
    _heart = heart;
    print("startHeart = ${heart}");
    // notifyListeners();
  }

  void decrease() {
    _heart--;
    print(_heart);
    notifyListeners();
  }

// void s
}
