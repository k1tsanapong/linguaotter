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

class LearningMode extends StatefulWidget {
  LearningMode({super.key});

  @override
  _LearningModeState createState() => _LearningModeState();
}

class _LearningModeState extends State<LearningMode> {
  late List<ChinaCharacters> chiQues;

  int numQues = 0;

  @override
  void initState() {
    chiQues = context.read<QuestionChinaProvider>().allChineseWords;
    super.initState();
  }

  void nextClick() {
    if (numQues < chiQues.length - 1) {
      numQues++;
    } else {
      Navigator.pop(context);
    }
  }

  void previousClick() {
    if (numQues > 0) {
      numQues--;
    } else {
      Navigator.pop(context);
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
    Widget nextButton = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 2.2,
        heightButton: 110,
        textDisplay: 'Next',
        run: () => setState(() => nextClick()));

    Widget previousButton = ThemeApp.NomalButtonShape(
        context: context,
        widthButton: 2.2,
        heightButton: 110,
        textDisplay: 'Previous',
        run: () => setState(() => previousClick()));

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
        const SizedBox(height: 20),
        Container(
          height: 60,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${chiQues[numQues].pinyin}',
              style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[800]),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 80,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${chiQues[numQues].eng_meaning}',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(height: MediaQuery.of(context).size.height / 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            previousButton,
            const SizedBox(width: 15),
            nextButton,
          ],
        ),
      ],
    );
  }
}
