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

class PracticeMode extends StatefulWidget {
  PracticeMode({super.key});

  @override
  _PracticeModeState createState() => _PracticeModeState();
}

class _PracticeModeState extends State<PracticeMode> {
  late List<ChinaCharacters> chiQues;

  late ChinaCharacters wrongOne;

  int numQues = 0;

  int score = 0;

  @override
  void initState() {
    chiQues = context.read<QuestionChinaProvider>().allChineseWords;
    wrongOne = context.read<QuestionChinaProvider>().getRandom1;

    while (wrongOne.character == chiQues[numQues].character) {
      wrongOne = context.read<QuestionChinaProvider>().getRandom1;
    }

    super.initState();
  }

  void navigateToCongrats() {
    Navigator.pushReplacementNamed(context, "/congrats", arguments: {
      "mode": "EZ",
      "score": score,
    });
  }

  void correctClick() {
    score++;
    showSnackBar(context, "Good");

    if (numQues < chiQues.length - 1) {
      numQues++;

      do {
        wrongOne = context.read<QuestionChinaProvider>().getRandom1;
      } while (wrongOne.character == chiQues[numQues].character);
    } else {
      navigateToCongrats();
    }
  }

  void wrongCLick() {
    showSnackBar(context, "Wrong");

    if (numQues < chiQues.length - 1) {
      numQues++;
      do {
        wrongOne = context.read<QuestionChinaProvider>().getRandom1;
      } while (wrongOne.character == chiQues[numQues].character);
    } else {
      navigateToCongrats();
    }
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
        widthButton: 1.2,
        heightButton: 110,
        textDisplay: '${chiQues[numQues].eng_meaning}',
        //✔
        run: () => setState(() => correctClick()));

    Widget wrongChoice_1 = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 1.2,
        heightButton: 110,
        textDisplay: '${wrongOne.eng_meaning}',
        //❌
        run: () => setState(() => wrongCLick()));

    List<Widget> questions = [
      correctChoice,
      wrongChoice_1,
    ];

    questions.shuffle();

    return NormalLayout(
      head: [
        const Expanded(child: BackToTheFuture()),
        showLimit(),
          Expanded(
           child: Row(),
         ),


      ],
      betweenHeadAndBody: 0,
      body: [
        Container(
          height: 200,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          alignment: Alignment.center,
          child:
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${chiQues[numQues].character}',
              style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[800]
              ),
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
        questions[0],
        const SizedBox(height: 15),
        questions[1],
      ],
    );
  }
}
