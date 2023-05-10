// import 'package:flutter/material.dart';
// import '../pages/home_screen.dart';
//
// class OauthButton extends StatelessWidget {
//   final String pathImageFileName;
//   final BuildContext context;
//   const OauthButton(this.pathImageFileName, this.context, {super.key});
//
//   @override
//   Widget build(context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) =>  HomeScreen()));
//       },
//       child: Container(
//         width: 64,
//         height: 64,
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(pathImageFileName),
//               fit: BoxFit.fill,
//             ),
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.transparent,
//             border: Border.all(
//               color: Colors.white,
//               width: 3.0,
//             )),
//
//         // child:
//       ),
//     );
//   }
// }
