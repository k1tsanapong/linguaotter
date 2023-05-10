import 'package:flutter/material.dart';
import 'package:linguaotter/components/normal_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static const violetTheme = Color(0xff9747FF);

  static BoxDecoration background() {
    const blueBackgroundColor = Color(0xff32CEFF);
    const violetBackgroundColor = Color(0xff8B62FF);
    return const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        blueBackgroundColor,
        violetBackgroundColor,
      ],
    ));
  }

  static SizedBox loginButtonShape(
      {required BuildContext context,
      double? widthButton,
      required String textDisplay}) {
    if (widthButton != null) {
      widthButton = MediaQuery.of(context).size.width / widthButton;
    }

    return SizedBox(
      width: widthButton,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: violetTheme,
            width: 4.0,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, right: 10.0, bottom: 10.0),
            child: Text(
              // softWrap: true,
              textAlign: TextAlign.center,
              '${textDisplay}',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static InkWell NomalButtonShape(
      {required BuildContext context,
      required double widthButton,
      required double heightButton,
      required String textDisplay,
      Function()? run}) {
    return InkWell(
      onTap: () {
        if (run != null) {
          run();
        } else {
          print("No  run");
        }
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
          child: Text('${textDisplay}',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.8)))),
    );
  }
}

class BackToTheFuture extends StatelessWidget {

   final Function()? run;

  const BackToTheFuture({Key? key, this.run}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: AlignmentDirectional.topStart,
      child: InkWell(
          onTap: () {

            if (run != null) {
              run!();
            } else {
              print("No  run");
            }

            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 35.0,
          )),
    );
  }
}
