import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/icon_text.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ArmyBody extends StatelessWidget {
  final double iconSize;
  final Army army;
  const ArmyBody({super.key, required this.army, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          IconAndText(
              text: army.getTotalDmg().toString(),
              icon: GameIcons.burning_meteor,
              iconSize: iconSize,
              iconColor: Colors.red),
          const SizedBox(width: 10),
          IconAndText(
              text: army.getTotalLife().toString(),
              icon: GameIcons.hearts,
              iconSize: iconSize,
              iconColor: Colors.green),
          const SizedBox(width: 10),
          IconAndText(
              text: army.getTotalFood().toString(),
              icon: GameIcons.chicken_leg,
              iconSize: iconSize,
              iconColor: Colors.amber),
          const Spacer(),
          IconAndText(
            text: ": ",
            icon: GameIcons.queen_crown,
            iconSize: iconSize,
            iconColor: Colors.blue[600],
          ),
          Icon(unitTypeToIcon(army.specType), size: 16)
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconAndText(
              text: army.nbSwords.toString(),
              icon: GameIcons.broadsword,
              iconSize: iconSize),
          IconAndText(
              text: army.nbArchers.toString(),
              icon: GameIcons.crossbow,
              iconSize: iconSize),
          IconAndText(
              text: army.nbSpears.toString(),
              icon: GameIcons.spear_head,
              iconSize: iconSize),
          IconAndText(
              text: army.nbHorses.toString(),
              icon: GameIcons.horse_head,
              iconSize: iconSize),
          IconAndText(
              text: army.nbGrenadiers.toString(),
              icon: GameIcons.bomb,
              iconSize: iconSize),
          IconAndText(
              text: army.nbCatapults.toString(),
              icon: GameIcons.tower,
              iconSize: iconSize)
        ],
      ),
    ]);
  }
}
