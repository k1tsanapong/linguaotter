import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String? photoUrl;
  const UserProfile({super.key, this.photoUrl});

  photoRender() {
    if (photoUrl == null || photoUrl == "") {
      return Image.asset(
        'assets/images/OTs_12.png',
        fit: BoxFit.cover,
      )
      ;
    }

    return Image.network(photoUrl!);
  }

  @override
  Widget build(BuildContext context) {
    const violetTheme = Color(0xff9747FF);

    final borderRadius = BorderRadius.circular(38.4); // Image border

    return Container(
        padding: const EdgeInsets.all(4), // Border width
        decoration:
            BoxDecoration(color: violetTheme, borderRadius: borderRadius),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox.fromSize(
            size: const Size.fromRadius(40), // Image radius
            child: photoRender(),
          ),
        ));
  }
}
