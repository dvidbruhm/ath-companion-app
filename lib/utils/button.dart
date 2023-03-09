import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      color: color,
      child: Text(text),
    );
  }
}
