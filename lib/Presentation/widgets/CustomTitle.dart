import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  CustomTitle(this.title);
  String title;

  @override
  Widget build(BuildContext context) {
    return const Text("Hope Football Scout",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ));
  }
}
