import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import '../components/showSnackbar.dart';
import '../components/theme_app.dart';

class SettingScreen extends StatelessWidget {

  SettingScreen({Key? key}) : super(key: key);

  User user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore db = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ThemeApp.background(),
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(height: 60),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: BackToTheFuture()),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  alignment: AlignmentDirectional.center,
                  child: Text("Setting",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                Expanded(child: Container())
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            LongMenuButton(
              iconName: Icons.manage_accounts,
              titleName: 'Edit profile',
              run: () =>  Navigator.pushNamed(context, '/edit-profile'),

            ),

            const SizedBox(
              height: 25,
            ),

            LongMenuButton(
              iconName: Icons.person_remove,
              titleName: 'Delete Account',
              run: () {
                if (user.isAnonymous) {
                  showSnackBar(context, "You are Anonymous");
                }

                else{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Account'),
                          content: const Text('Are you sure you want to delete your account?'),
                          actions: [
                            TextButton(
                              onPressed: () {

                                user.delete();
                                db.collection("users").doc(user.uid).delete();

                                Navigator.popUntil(context, ModalRoute.withName('/'));
                              },
                              child: const Text('Delete',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );

                }

              },

            ),

            const SizedBox(
              height: 25,
            ),

            LongMenuButton(
              iconName: Icons.exit_to_app,
              titleName: 'Log out',
              run: () {
                try {
                  FirebaseAuth.instance.signOut();
                } on FirebaseAuthException catch (e) {
                  showSnackBar(
                      context, e.message!); // Displaying the error message
                }
                // FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),

            const SizedBox(
              height: 25,
            ),

          ]),
        ),
      ),
    );
  }

}
