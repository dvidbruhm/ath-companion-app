import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/unit_input.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';

class UnitInputs extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controllers;
  final ArmyCallback onChanged;
  final Army army;
  const UnitInputs(
      {super.key,
      required this.controllers,
      required this.onChanged,
      required this.army});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Enter unit numbers :")],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UnitInput(
              icon: GameIcons.broadsword,
              controller: controllers["sword"],
              onChange: onChanged,
              army: army,
            ),
            UnitInput(
              icon: GameIcons.crossbow,
              controller: controllers["archer"],
              onChange: onChanged,
              army: army,
            ),
            UnitInput(
              icon: GameIcons.spear_head,
              controller: controllers["spear"],
              onChange: onChanged,
              army: army,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UnitInput(
              icon: GameIcons.horse_head,
              controller: controllers["horse"],
              onChange: onChanged,
              army: army,
            ),
            UnitInput(
              icon: GameIcons.bomb,
              controller: controllers["grenadier"],
              onChange: onChanged,
              army: army,
            ),
            UnitInput(
              icon: GameIcons.tower,
              controller: controllers["catapult"],
              onChange: onChanged,
              army: army,
            ),
          ],
        ),
      ],
    );
  }
}
