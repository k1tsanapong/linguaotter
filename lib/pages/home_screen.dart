import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linguaotter/providers/counter_provider.dart';
import 'package:provider/provider.dart';
import '../components/theme_app.dart';
import '../components/normal_button.dart';
import '../components/user_profile.dart';
import '../providers/china_quest.dart';

class HomeScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  disPlayName() {
    if (user.isAnonymous == true) {
      return "Guest";
    }

    if ((user.displayName) != "null" || user.displayName != null  ) {
      print("User : ${user.displayName}");
      // context.read<FirebaseAuth>().
      return user.displayName;
    }

    int? index = user.email?.indexOf('@');

    if (index != -1) {
      return user.email?.substring(0, index);
    } else {
      return user.email;
    }
  }

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    String userName = disPlayName();

    return Scaffold(
      body: Container(
        decoration: ThemeApp.background(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 60),
            Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hello,",
                            style: TextStyle(
                              fontFamily: 'Inter-Light',
                              fontSize: 50,
                              fontWeight: FontWeight.w400,
                            )),
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [UserProfile(photoUrl: user.photoURL)]),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(mainAxisSize: MainAxisSize.max, children: [
                          Text(
                            '${userName}',
                            style: const TextStyle(
                              fontFamily: 'Inter-Light',
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: const EdgeInsets.only(left: 36.0),
              child: const Text("Let's play",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            const SizedBox(height: 60),
            Expanded(
                child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalButton(
                            'Competition', 1.5, 130, '/select-difficulty',
                            run: () {})
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        NormalButton('Practice \n Mode', 3, 130, '/practice-mode'),
                        NormalButton('Learning \n Content', 3, 130, '/learning-mode')
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // IconButton(
                        //     padding: EdgeInsets.zero,
                        //     onPressed: () => Navigator.pushNamed(context, '/test-kim') , icon: const Icon(
                        //
                        //   Icons.home_outlined,
                        //   size: 50,
                        //   color: Colors.white,
                        // )),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.pushNamed(context, '/score-board') , icon: const Icon(
                          Icons.bar_chart_outlined,
                          size: 50,
                          color: Colors.white,
                        )),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.pushNamed(context, '/settings') , icon: const Icon(
                          Icons.settings,
                          size: 50,
                          color: Colors.white,
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
