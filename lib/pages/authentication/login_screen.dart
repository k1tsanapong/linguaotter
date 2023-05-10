import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../components/login_text_box.dart';
import '../../components/showSnackbar.dart';
import '../../components/theme_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ThemeApp.background(),
        child: Column(
          children: [
            const SizedBox(height: 50),
            logoOtter(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      LoginTextBox(
                          titleName: 'Email',
                          iconName: Icons.email,
                          textController: emailController),
                      const SizedBox(height: 25),
                      LoginTextBox(
                          setobscureText: true,
                          titleName: 'Password',
                          iconName: Icons.lock,
                          textController: passwordController),
                      const SizedBox(height: 35),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            // ContinueButton( MediaQuery.of(context).size.width / 4,inputText: 'KIM')
                            loginButton(
                                context: context,
                                textDisplay: "Log in",
                                widthButton: 3.5,
                                routeScreen: '/'),

                            const SizedBox(width: 10),
                            Expanded(
                              child: guestButton(
                                  context: context,
                                  textDisplay: "Continue as guest",
                                  routeScreen: '/'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                signInWithGoogle(context);
                              },
                              child: OauthButton(
                                  'assets/images/google_2.png', context)),
                        ],
                      ),
                      const SizedBox(height: 34),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                textAlign: TextAlign.center,
                                "Need an account ?",
                                style: GoogleFonts.inter(
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(0.0, 4.0),
                                      blurRadius: 6.0,
                                      color: Color.fromARGB(63, 0, 0, 0),
                                    )
                                  ],
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/sign-up');
                              },
                              child: Text(
                                  textAlign: TextAlign.center,
                                  "Sign Up",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ])
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signInAnon() async {
    await _auth.signInAnonymously().then((user) {

      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

      print("signed in ");
    }).catchError((error) {
      print(error);
    });
  }

  Future signInWithGoogle(BuildContext context) async {
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) => Center(child: CircularProgressIndicator()));
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');


        // await _auth.signInWithPopup(googleProvider);

        UserCredential userCredential = await _auth.signInWithPopup(googleProvider);

        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {

            final user = userCredential.user;

            await db.collection("users").doc(user?.uid).set({
              "fullName": user?.displayName, // Full Name I will edit later
              "uid": user?.uid,
              "email": user?.email,
              "score": 0,
              "photoURL": user?.photoURL,

            }).then((value) {
              print("Sign up user successful.");
              showSnackBar(context, "Sign up user successful.");
              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            }).catchError((e) {
              print("Error : ${e}");
              showSnackBar(context,
                  "db error"); // Displaying the usual firebase error message
            });

          }
        }

      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          if (userCredential.user != null) {
            if (userCredential.additionalUserInfo!.isNewUser) {

              final user = userCredential.user;

              await db.collection("users").doc(user?.uid).set({
                "fullName": user?.displayName, // Full Name I will edit later
                "uid": user?.uid,
                "email": user?.email,
                "score": 0,
                "photoURL": user?.photoURL,

              }).then((value) {
                print("Sign up user successful.");
                showSnackBar(context, "Sign up user successful.");
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              }).catchError((e) {
                print("Error : ${e}");
                showSnackBar(context,
                    "db error"); // Displaying the usual firebase error message
              });

            }
          }
        }
      }
      showSnackBar(context, "signed in ");

      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

      print("signed in ");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      print(e.message!); // Displaying the error message
    }
  }

  Future signIn() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(child: CircularProgressIndicator()));

    try{
      await _auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((user) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

        print("signed in ");
      });
    }  on FirebaseAuthException catch (e) {
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    } catch (e) {
      print("Error Something : ${e}");
      showSnackBar(context, "${e}");
    }
  }

  Widget loginButton(
      {required BuildContext context,
      required String textDisplay,
      double? widthButton,
      required String routeScreen}) {
    return InkWell(
      onTap: () {
        signIn();
      },
      child: ThemeApp.loginButtonShape(
          context: context, textDisplay: textDisplay, widthButton: widthButton),
    );
  }

  Widget guestButton(
      {required BuildContext context,
      required String textDisplay,
      double? widthButton,
      required String routeScreen}) {
    return InkWell(
      onTap: () {
        signInAnon();
      },
      child: ThemeApp.loginButtonShape(
          context: context, textDisplay: textDisplay, widthButton: widthButton),
    );
  }

  Widget logoOtter() {
    final borderRadius = BorderRadius.circular(15); // Image border

    return Container(
        padding: const EdgeInsets.all(6), // Border width
        decoration: BoxDecoration(
            color: ThemeApp.violetTheme, borderRadius: borderRadius),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox.fromSize(
            size: const Size.fromRadius(60), // Image radius
            child: Image.asset(
              'assets/images/logo_china.png',
            ),
          ),
        ));
  }

  Widget OauthButton(String pathImageFileName, BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(pathImageFileName),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          )),

      // child:
    );
  }
}
