import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitInput extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final Color? iconColor;
  final ArmyCallback onChange;
  final Army army;
  const UnitInput(
      {super.key,
      required this.icon,
      required this.controller,
      this.iconColor = Colors.white,
      required this.onChange,
      required this.army});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 30,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              LengthLimitingTextInputFormatter(2)
            ],
            decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                border: OutlineInputBorder()),
            onChanged: (value) => onChange(army),
          ),
        ),
      ],
    );
  }
}
