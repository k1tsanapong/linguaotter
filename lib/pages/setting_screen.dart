import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import '../components/showSnackbar.dart';
import '../components/theme_app.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
            Row(
              children: [
                Icon(
                  Icons.manage_accounts,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Edit profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                try {
                  FirebaseAuth.instance.signOut();
                } on FirebaseAuthException catch (e) {
                  showSnackBar(
                      context, e.message!); // Displaying the error message
                }
                // FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/login');
              },
              child: Row(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(
                      Icons.exit_to_app,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Log out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
