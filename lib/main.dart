import 'package:flutter/material.dart';
import 'package:linguaotter/pages/competition/hard_mode.dart';
import 'package:linguaotter/pages/congrats.dart';
import 'package:linguaotter/pages/competition/easy_mode.dart';
import 'package:linguaotter/pages/edit_profile.dart';
import 'package:linguaotter/pages/home_screen.dart';
import 'package:linguaotter/pages/competition/medium_mode.dart';
import 'package:linguaotter/pages/competition/select_difficulty.dart';
import 'package:linguaotter/pages/learning_content.dart';
import 'package:linguaotter/pages/score_board.dart';
import 'package:linguaotter/pages/setting_screen.dart';
import 'package:linguaotter/pages/authentication/sign_up_screen.dart';
import 'package:linguaotter/pages/test_kim.dart';
import 'package:linguaotter/pages/practice_mode.dart';
import 'package:linguaotter/providers/china_quest.dart';
import 'package:linguaotter/providers/counter_provider.dart';
import 'package:linguaotter/providers/heart.dart';
import 'package:linguaotter/providers/timer.dart';
import 'package:linguaotter/providers/users_score_load.dart';
import 'pages/authentication/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterStrike()),
        ChangeNotifierProvider(create: (_) => QuestionChinaProvider()),
        ChangeNotifierProvider(create: (_) => Heart()),
        ChangeNotifierProvider(create: (_) => TimerCount()),
        ChangeNotifierProvider(create: (_) => UserScoreProvider())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "LinguaOtter",
        home: MainPage(),
        initialRoute: '/',
        routes: {
          '/home': (ctx) => HomeScreen(),
          '/easy-mode': (ctx) => EasyMode(),
          '/medium-mode': (ctx) => MediumMode(),
          '/hard-mode': (ctx) => HardMode(),
          '/select-difficulty': (ctx) => SelectDifficulty(),
          '/login': (ctx) => LoginScreen(),
          '/sign-up': (ctx) => SignUpScreen(),
          '/settings': (ctx) => SettingScreen(),
          '/test-kim': (ctx) => TestKim(),
          '/congrats': (ctx) => Congrats(),
          '/practice-mode': (ctx) => PracticeMode(),
          '/learning-mode': (ctx) => LearningMode(),
          '/score-board': (ctx) => ScoreBoard(),
          '/edit-profile': (ctx) => EditProfile(),

        },
      ),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionChinaProvider>().initialD();
    });

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
