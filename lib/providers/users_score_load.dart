import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:linguaotter/models/users_score.dart';

import '../models/china_characters.dart';

class UserScoreProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


    Future<List<UserScore>> getUsers() async {
    final usersRef = _db.collection('users').withConverter(
      fromFirestore: UserScore.fromFirestore,
      toFirestore: (userScore, _) => userScore.toFirestore(),
    );

    final querySnapshot = await usersRef.get();
    final users = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (users.isEmpty) {
      print('No users found');
    } else {
      print('Found ${users.length} users');
    }

    return users;
  }

}
