import 'package:flutter/material.dart';
import 'package:linguaotter/components/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextBox extends StatelessWidget {
  final String titleName;
  final IconData iconName;
  final TextEditingController textController;
  final bool? setobscureText;

  const LoginTextBox(
      {super.key,
      required this.titleName,
      required this.iconName,
      required this.textController,  this.setobscureText});

  @override
  Widget build(BuildContext context) {

    bool? setobscureTextInside = false;

    if (setobscureText == true)
      {
        setobscureTextInside = true;
      }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${titleName}',
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
          child: TextField(
            obscureText: setobscureTextInside,
            controller: textController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20),
              // border: InputBorder.none,
              prefixIcon: Icon(
                iconName,
                color: Colors.black,
              ),
              hintText: '${titleName}',
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
        ),
      ],
    );
  }
}
