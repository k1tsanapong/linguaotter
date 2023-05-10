import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/china_characters.dart';

class QuestionChinaProvider with ChangeNotifier {
  bool check_input_yet = true;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _random = new Random();

  List<ChinaCharacters> allChineseWords = [];
  List<ChinaCharacters> random10 = [];
  int index = 0;

  // final _random = new Random();

  // List<ChinaCharacters> get getRandom10 => Random10;

  int get getIndex => index;

  List<ChinaCharacters> get getChina => allChineseWords;

  // void startRandom10 ()
  // {
  //   List<ChinaCharacters> randomList = List.from(allChineseWords);
  //   randomList.shuffle();
  //   List<ChinaCharacters> newList  = randomList.take(10).toList();
  //   random10 = newList;
  //   notifyListeners();
  // }
  ChinaCharacters get getRandom1 =>
      allChineseWords[_random.nextInt(allChineseWords.length)];

  List<ChinaCharacters> get getRandom10 {
    List<ChinaCharacters> randomList = List.from(allChineseWords);
    randomList.shuffle();
    List<ChinaCharacters> newList = randomList.take(10).toList();
    random10 = newList;
    // notifyListeners();
    return newList;
  }

  void initialD() {
    if (check_input_yet == true) {
      _db
          .collection("chinese_words")
          .withConverter(
            fromFirestore: ChinaCharacters.fromFirestore,
            toFirestore: (ChinaCharacters chinaCharacters, _) =>
                chinaCharacters.toFirestore(),
          )
          .limit(20)
          .get()
          .then((QuerySnapshot<ChinaCharacters> querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          for (var docSnapshot in querySnapshot.docs) {
            allChineseWords.add(docSnapshot.data());
          }
          print("Succ Provider China.");
          print(allChineseWords.length);
          check_input_yet = false;
          notifyListeners();
        } else {
          print("No such document.");
          notifyListeners();
        }
      }).catchError((err) {
        print("allChineseWords Error : ${err}");
      });
    } else {
      print("input again?");
    }
  }
}
