import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linguaotter/layouts/default.dart';
import 'package:linguaotter/models/users_score.dart';
import '../components/theme_app.dart';
import '../components/user_profile.dart';

class ScoreBoard extends StatelessWidget {
  ScoreBoard({Key? key}) : super(key: key);

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<UserScore>> getUsers() async {
    final usersRef = _db.collection('users').withConverter(
          fromFirestore: UserScore.fromFirestore,
          toFirestore: (userScore, _) => userScore.toFirestore(),
        );

    final querySnapshot =
        await usersRef.orderBy('score', descending: true).get();
    final users = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (users.isEmpty) {
      print('No users found');
    } else {
      print('Found ${users.length} users');
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return NormalLayout(
      head: [
        const Expanded(child: BackToTheFuture()),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          alignment: AlignmentDirectional.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: const Text(
              " Score Board Hard Mode ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Expanded(child: Container())
      ],
      body: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: FutureBuilder(
            future: getUsers(),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserScore>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error loading user scores'));
              }
              final allUsers = snapshot.data;
              final allUsersDisplay = allUsers
                  ?.map(
                    (user) => Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [UserProfile(photoUrl: user.photoURL)],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Best Score ${user.score}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                  .toList();
              return Column(
                children: [...?allUsersDisplay],
              );
            },
          ),
        ),
      ],
    );
  }
}
