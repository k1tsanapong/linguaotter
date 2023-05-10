import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/showSnackbar.dart';
import '../components/theme_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linguaotter/providers/counter_provider.dart';

import '../providers/china_quest.dart';

class TestKim extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  TestKim({Key? key}) : super(key: key);

  Future testAdd(BuildContext context) async {
    final docUser = FirebaseFirestore.instance.collection("test-kim");

    final json = {'test_1': "comfy time", 'test_2': "Pastel"};

    await docUser
        .add(json)
        .then((value) => showSnackBar(context, "test-kim Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

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
                  child: Text("Test",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                Expanded(
                    child: Container(
                        ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            testButton(
                titleName: "Test onTap show SnackBar",
                iconName: Icons.telegram,
                run: () {
                  _db.collection("test-kim").get().then(
                    (querySnapshot) {
                      print("Successfully completed");
                      for (var docSnapshot in querySnapshot.docs) {
                        print('${docSnapshot.id} => ${docSnapshot.data()}');
                      }
                    },
                    onError: (e) => print("Error completing: $e"),
                  );
                  showSnackBar(context, "test");
                }),
            testButton(
                titleName: "Add Something",
                iconName: Icons.perm_identity,
                run: () {
                  testAdd(context);
                  showSnackBar(context, "Add Something to database");
                }),
            testButton(
                titleName: "Increase count maichi lao",
                iconName: Icons.text_increase,
                run: () {
                  context.read<CounterStrike>().increase();
                  showSnackBar(context, "${context.read<CounterStrike>().count}");
                }),
            testButton(
                titleName: "Initial D",
                iconName: Icons.car_crash,
                run: () {
                  // context.read<QuestionChinaProvider>().initialD();
                  showSnackBar(context, "Cancel");
                }),
            testButton(
                titleName: "Get China",
                iconName: Icons.get_app,
                run: () {
                  print(context.read<QuestionChinaProvider>().getChina);
                  showSnackBar(context, "Printed");
                }),
            testButton(
                titleName: "Get China",
                iconName: Icons.get_app,
                run: () {
                  print(context.read<QuestionChinaProvider>().getRandom10.length);
                  showSnackBar(context, "Printed");
                }),
          ]),
        ),
      ),
    );
  }

  testButton(
      {required String titleName,
      required IconData iconName,
      Function()? run}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (run != null) {
              run();
            } else {
              print("No  run");
            }
          },
          child: Row(

            children: [
              Icon(
                iconName,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text('${titleName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
