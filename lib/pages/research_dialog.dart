import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/button.dart';
import 'package:bgame_app/utils/icon_text.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ResearchDialog extends StatefulWidget {
  final bool specResearch;
  final BoolCallback onSave;
  final VoidCallback onCancel;

  const ResearchDialog(
      {super.key,
      required this.onSave,
      required this.onCancel,
      required this.specResearch});

  @override
  State<ResearchDialog> createState() => _ResearchDialogState();
}

class _ResearchDialogState extends State<ResearchDialog> {
  late bool specResearch = widget.specResearch;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      content: SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: ThemeData().bottomAppBarColor)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(GameIcons.round_bottom_flask, color: Colors.blue[600]),
                    const Spacer(),
                    const Text("Research"),
                    const Spacer(),
                    Icon(GameIcons.round_bottom_flask, color: Colors.blue[600])
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconAndText(
                    text: "Specialisations : ",
                    icon: GameIcons.queen_crown,
                    iconSize: 24,
                    iconColor: Colors.blue[600]),
                Checkbox(
                  activeColor: Colors.blue[600],
                  value: specResearch,
                  onChanged: (value) {
                    setState(() {
                      specResearch = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    text: "Save",
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onSave(specResearch);
                    },
                    color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Button(
                    text: "Cancel",
                    onPressed: widget.onCancel,
                    color: Theme.of(context).primaryColor)
              ],
            )
          ],
        ),
      ),
    );
  }
}
