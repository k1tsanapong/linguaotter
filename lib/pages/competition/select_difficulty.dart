import 'package:linguaotter/layouts/default.dart';
import 'package:linguaotter/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/normal_button.dart';
import '../../components/theme_app.dart';

class SelectDifficulty extends StatelessWidget {
  const SelectDifficulty({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) {
    //
    //   Future.delayed(Duration.zero, () {
    //     context.read<CounterStrike>().increase();
    //   });
    //
    // });

    return NormalLayout(
      head: [
        const Expanded(child: BackToTheFuture()),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          alignment: AlignmentDirectional.center,
          child: const Text("Competition",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              )),
        ),
        Expanded(child: Container())
      ],
      body:  [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90.0),
                  border: Border.all(
                    color: ThemeApp.violetTheme,
                    width: 4.0,
                  ),
                ),
                width: MediaQuery.of(context).size.width / 1.7,
                padding: EdgeInsets.all(20.0),
                height: 175,
                alignment: AlignmentDirectional.center,
                child: const Text('Illustration',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('select difficulty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              NormalButton('★\nEasy', 1.5, 100, '/easy-mode'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              NormalButton('★★\nMedium', 1.5, 100, '/medium-mode'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              NormalButton('★★★\nHard', 1.5, 100, '/hard-mode'),
            ],
          ),
        ],

    );
  }
}
