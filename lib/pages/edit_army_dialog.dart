import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/army_header.dart';
import 'package:bgame_app/utils/button.dart';
import 'package:bgame_app/utils/icon_text.dart';
import 'package:bgame_app/utils/unit_inputs.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';

class EditArmyDialog extends StatefulWidget {
  final Army army;
  // ignore: prefer_typing_uninitialized_variables
  final controllers;
  final ArmyCallback onSave;
  final VoidCallback onCancel;

  const EditArmyDialog(
      {super.key,
      required this.army,
      required this.controllers,
      required this.onSave,
      required this.onCancel});

  @override
  State<EditArmyDialog> createState() => _EditArmyDialogState();
}

class _EditArmyDialogState extends State<EditArmyDialog> {
  late Army tempArmy = widget.army;
  void updateArmy(Army army) {
    Army updatedArmy = Army(army.armyNb, army.generalName, 0, 0, 0, 0, 0, 0);

    updatedArmy.nbSwords = int.parse(widget.controllers["sword"]?.text == ""
        ? "0"
        : widget.controllers["sword"]?.text ?? "");
    updatedArmy.nbArchers = int.parse(widget.controllers["archer"]?.text == ""
        ? "0"
        : widget.controllers["archer"]?.text ?? "");
    updatedArmy.nbSpears = int.parse(widget.controllers["spear"]?.text == ""
        ? "0"
        : widget.controllers["spear"]?.text ?? "");
    updatedArmy.nbHorses = int.parse(widget.controllers["horse"]?.text == ""
        ? "0"
        : widget.controllers["horse"]?.text ?? "");
    updatedArmy.nbGrenadiers = int.parse(
        widget.controllers["grenadier"]?.text == ""
            ? "0"
            : widget.controllers["grenadier"]?.text ?? "");
    updatedArmy.nbCatapults = int.parse(
        widget.controllers["catapult"]?.text == ""
            ? "0"
            : widget.controllers["catapult"]?.text ?? "");

    setState(() {
      tempArmy = updatedArmy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      content: SizedBox(
        height: 250,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArmyHeader(army: widget.army, iconSize: 20),
              UnitInputs(
                controllers: widget.controllers,
                onChanged: updateArmy,
                army: tempArmy,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: Row(children: [
                      IconAndText(
                          text: tempArmy.getTotalDmg().toString(),
                          icon: GameIcons.burning_meteor,
                          iconSize: 20,
                          iconColor: Colors.red),
                      const SizedBox(width: 10),
                      IconAndText(
                          text: tempArmy.getTotalLife().toString(),
                          icon: GameIcons.hearts,
                          iconSize: 20,
                          iconColor: Colors.green),
                      const SizedBox(width: 10),
                      IconAndText(
                          text: tempArmy.getTotalFood().toString(),
                          icon: GameIcons.chicken_leg,
                          iconSize: 20,
                          iconColor: Colors.amber),
                    ]),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 70,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconAndText(
                            text: ": ",
                            icon: GameIcons.queen_crown,
                            iconSize: 20,
                            iconColor: Colors.blue[600]),
                        Icon(unitTypeToIcon(widget.army.specType), size: 20)
                      ],
                    ),
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
                        widget.onSave(widget.army);
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
            ]),
      ),
    );
  }
}
