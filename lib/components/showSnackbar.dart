import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 250),
      content: Text(text),
    ),
  );
}
