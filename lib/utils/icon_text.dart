import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final String text;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  const IconAndText(
      {super.key,
      required this.text,
      required this.icon,
      required this.iconSize,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,
            size: iconSize,
            color: iconColor ?? Theme.of(context).iconTheme.color),
        const SizedBox(width: 5),
        Text(text)
      ],
    );
  }
}
