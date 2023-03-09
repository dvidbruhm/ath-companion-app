import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/icon_text.dart';
import 'package:flutter/material.dart';

class ArmyHeader extends StatelessWidget {
  final Army army;
  final double iconSize;

  const ArmyHeader({super.key, required this.army, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: Row(
          children: [
            IconAndText(
              text: army.generalName,
              icon: GameIcons.helmet,
              iconSize: iconSize,
              iconColor: Colors.cyan[800],
            ),
            const Spacer(),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).toggleableActiveColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(" ${army.armyNb.toString()} ",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)))
          ],
        ));
  }
}
