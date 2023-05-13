import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linguaotter/layouts/default.dart';
import 'package:linguaotter/components/showSnackbar.dart';
import 'package:linguaotter/components/theme_app.dart';
import 'package:linguaotter/pages/home_screen.dart';
import 'package:linguaotter/providers/china_quest.dart';
import 'package:linguaotter/providers/counter_provider.dart';
import 'package:provider/provider.dart';

import '../../models/china_characters.dart';
import '../../providers/heart.dart';
import '../../providers/timer.dart';

class HardMode extends StatefulWidget {
  HardMode({super.key});

  @override
  _HardModeState createState() => _HardModeState();
}

class _HardModeState extends State<HardMode> {
  late List<ChinaCharacters> chiQues;

  late List<ChinaCharacters> choiceQues;

  late ChinaCharacters wrongOne_1;
  late ChinaCharacters wrongOne_2;
  late ChinaCharacters wrongOne_3;

  int numQues = 0;
  int oldsSore = 0;
  int score = 0;

  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    chiQues = context.read<QuestionChinaProvider>().getRandom10;
    context.read<Heart>().startHeart(1);
    setQuestions();
    getOldScore();

    context.read<TimerCount>().startTimer(
        context: context, score: score, mode: "Hard", setTimeSecond: 10);
    super.initState();
  }

  void setQuestions() {
    do {
      wrongOne_1 = context.read<QuestionChinaProvider>().getRandom1;
      wrongOne_2 = context.read<QuestionChinaProvider>().getRandom1;
      wrongOne_3 = context.read<QuestionChinaProvider>().getRandom1;

      choiceQues = [];
      choiceQues.add(chiQues[numQues]);
      choiceQues.add(wrongOne_1);
      choiceQues.add(wrongOne_2);
      choiceQues.add(wrongOne_3);
    } while (choiceQues.any((choiceQuestion) =>
        choiceQues.indexOf(choiceQuestion) !=
        choiceQues.lastIndexOf(choiceQuestion)));
  }

  void thisIsTheEnd() {
    context.read<TimerCount>().cancelTime();

    if (score > oldsSore) writeNewScore();

    navigateToCongrats();
  }

  void getOldScore() {
    if (user.isAnonymous == false) {
      final docRef = db.collection("users").doc(user.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          oldsSore = data["score"];
          print("oldsSore = ${oldsSore}");
        },
        onError: (e) {
          print("Error getting document: $e");
        },
      );
    }

    oldsSore = 999;
  }

  Future<void> writeNewScore() async {
    await db.collection("users").doc(user.uid).update({
      "score": score,
    }).then((value) {
      print("Update Score successful.");
      showSnackBar(context, "New Score");
    }).catchError((e) {
      print("Error : ${e}");
      showSnackBar(
          context, "db error"); // Displaying the usual firebase error message
    });
  }

  void navigateToCongrats() {
    Navigator.pushReplacementNamed(context, "/congrats", arguments: {
      "mode": "Hard",
      "score": score,
    });
  }

  void correctClick() {
    context.read<TimerCount>().resetTime();
    score++;
    showSnackBar(context, "Good");

    if (numQues < chiQues.length - 1) {
      numQues++;

      setQuestions();
    } else {
      thisIsTheEnd();
    }
  }

  void wrongCLick() {
    context.read<TimerCount>().resetTime();
    showSnackBar(context, "Wrong");
    context.read<Heart>().decrease();

    if (context.read<Heart>().getHeart == 0) thisIsTheEnd();

    if (numQues < chiQues.length - 1) {
      numQues++;
      setQuestions();
    } else {
      thisIsTheEnd();
    }
  }

  List<Widget> heartIcon() {
    return [
      Icon(
        Icons.favorite,
        color: Colors.red[600],
        size: 30,
      ),
      const SizedBox(
        width: 15,
      ),
    ];
  }

  Widget showLimit() {
    return Center(
        child: Text("${numQues + 1}/${chiQues.length}",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget correctChoice = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 2.2,
        heightButton: 110,
        textDisplay: '${chiQues[numQues].eng_meaning}',
        //✔
        run: () => setState(() => correctClick()));

    Widget wrongChoice_1 = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 2.2,
        heightButton: 110,
        textDisplay: '${wrongOne_1.eng_meaning}',
        //❌
        run: () => setState(() => wrongCLick()));

    Widget wrongChoice_2 = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 2.2,
        heightButton: 110,
        textDisplay: '${wrongOne_2.eng_meaning}',
        //❌
        run: () => setState(() => wrongCLick()));

    Widget wrongChoice_3 = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 2.2,
        heightButton: 110,
        textDisplay: '${wrongOne_3.eng_meaning}',
        //❌
        run: () => setState(() => wrongCLick()));

    List<Widget> questions = [
      correctChoice,
      wrongChoice_1,
      wrongChoice_2,
      wrongChoice_3,
    ];

    questions.shuffle();

    return NormalLayout(
      head: [
        Expanded(child: BackToTheFuture(
          run: () {
            context.read<TimerCount>().cancelTime();
          },
        )),
        TimeMy(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...heartIcon(),
              const HeartRemain(),
            ],
          ),
        ),
      ],
      betweenHeadAndBody: 0,
      body: [
        Container(
          height: 200,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${chiQues[numQues].character}',
              style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[800]),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text('what is this character',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            questions[0],
            const SizedBox(width: 15),
            questions[1],
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            questions[2],
            const SizedBox(width: 15),
            questions[3],
          ],
        ),
      ],
    );
  }
}

class HeartRemain extends StatelessWidget {
  const HeartRemain({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<Heart>().getHeart}',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ));
  }
}

class TimeMy extends StatelessWidget {
  const TimeMy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<TimerCount>().getTime}',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ));
  }
}
