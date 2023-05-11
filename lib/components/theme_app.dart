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

class LongMenuButton extends StatelessWidget {

  final String titleName;
  final IconData iconName;
  final Function()? run;

  const LongMenuButton({Key? key, required this.titleName, required this.iconName, this.run}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (run != null) {
              run!();
            } else {
              print("No  run");
            }
          },
          child: Row(

            children: [
              Icon(
                iconName,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text('${titleName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TextFormBox extends StatelessWidget {
  final String titleName;
  final IconData iconName;
  final TextEditingController textController;
  final bool? setobscureText;

  const TextFormBox({
    Key? key,
    required this.titleName,
    required this.iconName,
    required this.textController,
    this.setobscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$titleName',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeApp.violetTheme,
              width: 4.0,
            ),
          ),
          child: TextFormField(
            obscureText: setobscureText ?? false,
            controller: textController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: Icon(
                iconName,
                color: Colors.black,
              ),
              hintText: '$titleName',
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
        ),
      ],
    );
  }
}
