import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/button.dart';
import 'package:bgame_app/utils/unit_input.dart';
import 'package:flutter/material.dart';

class SpyDialog extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final spyController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const SpyDialog(
      {super.key,
      required this.spyController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      content: SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
                "You have been spied! Which general do you wish to reveal?"),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              UnitInput(
                  icon: GameIcons.helmet,
                  controller: spyController,
                  iconColor: Colors.cyan[800],
                  onChange: (army) {},
                  army: Army(-1, "", 0, 0, 0, 0, 0, 0))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    text: "Reveal",
                    onPressed: onSave,
                    color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Button(
                    text: "Cancel",
                    onPressed: onCancel,
                    color: Theme.of(context).primaryColor)
              ],
            )
          ],
        ),
      ),
    );
  }
}
