import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {

  final IconData iconName;
  final double setSize;
  final String routeScreen;
  final Function()? run;

  const MyIconButton({Key? key, required this.iconName,this.run, required this.routeScreen, required this.setSize}) : super(key: key);



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
      child: Icon(
        iconName,
        size: setSize,
        color: Colors.white,
      ),
    );
  }
}
