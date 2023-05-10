import 'package:flutter/material.dart';
import 'package:linguaotter/components/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalButton extends StatelessWidget {
  final String textDisplay;
  final double widthButton;
  final String routeScreen;
  final double heightButton;
  final Function()? run;
  // const NormalButton({super.key});
  const NormalButton(
      this.textDisplay, this.widthButton, this.heightButton, this.routeScreen,
      {super.key, this.run});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (run != null) {
          run!();
        } else {
          print("No  run");
        }

        Navigator.pushNamed(context, routeScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(45.0),
          border: Border.all(
            color: ThemeApp.violetTheme,
            width: 4.0,
          ),
        ),
        width: MediaQuery.of(context).size.width / widthButton,
        padding: EdgeInsets.all(20.0),
        height: heightButton,
        alignment: AlignmentDirectional.center,
        child: TextDisplay(textDisplay),
      ),
    );
  }
}

class TextDisplay extends StatelessWidget {
  final String? textDisplay;

  const TextDisplay(this.textDisplay, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${textDisplay}',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
            height: 1.5,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.8)));

  }
}
