import 'package:flutter/material.dart';

import '../pages/home_screen.dart';

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body:
//
//       const ChildPage(
//         // Pass the text to the state class
//         someText: 'Have a nice day!',
//       ),
//
//
//     );
//   }
// }

class ContinueButton extends StatefulWidget {
  // This is the text that will be passed to the state class
  final String inputText;
  final double? inputWidth;

  const ContinueButton(this.inputWidth, {Key? key, required this.inputText})
      : super(key: key);
  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  // This is the text that will be displayed
  late String displayText;
  late double? displayWidth;

  @override
  void initState() {
    // Initialize the displayText variable
    // with the variable "someText" from the ChildPage class
    displayWidth = widget.inputWidth;
    displayText = widget.inputText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xff9747FF),
              width: 4.0,
            ),
          ),
          child: Center(
            child: Padding(
                padding: EdgeInsets.only(
                    left: 5.0, top: 10.0, right: 10.0, bottom: 10.0),
                child: Text(displayText)),
          ),
        ),
      ),
    );
  }
}
