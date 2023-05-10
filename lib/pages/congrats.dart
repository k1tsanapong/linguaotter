import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../layouts/default.dart';
import '../components/theme_app.dart';
import '../providers/timer.dart';

class Congrats extends StatelessWidget {
  const Congrats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

     return NormalLayout(
      body: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/trophy.png',
            height: 300,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text("Congratulation!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 50,
          ),
          Text(
            textAlign: TextAlign.center,
            "You finished \nmode ${arguments?['mode'] ?? 'Mode Something'} \nwith ${arguments?['score'] ?? '-1'}",
            style: const TextStyle(
              fontFamily: 'Inter-Light',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
              // Navigator.of(context).popUntil((route) => route.isFirst);

              // Navigator.pushNamedAndRemoveUntil(context, '/congrats', ModalRoute.withName('/home'));
              // Navigator.pushReplacementNamed(context, "/");
              // Navigator.pushNamedAndRemoveUntil(
              //     context, '/', (Route<dynamic> route) => false);
              // Navigator.pop(context);
            },
            child: const Text("Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500)),
          )
        ],

    );
  }
}
