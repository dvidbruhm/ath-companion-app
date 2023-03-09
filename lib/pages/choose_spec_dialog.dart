import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/army_body.dart';
import 'package:bgame_app/utils/army_header.dart';
import 'package:bgame_app/utils/button.dart';
import 'package:bgame_app/utils/icon_text.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ChooseSpecDialog extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final Army army;
  final ArmyCallback onSave;
  final VoidCallback onCancel;
  const ChooseSpecDialog(
      {super.key,
      required this.army,
      required this.onSave,
      required this.onCancel});

  @override
  State<ChooseSpecDialog> createState() => _ChooseSpecDialogState();
}

class _ChooseSpecDialogState extends State<ChooseSpecDialog> {
  late UnitType dropdownValue = widget.army.getMajorityUnit().first;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      content: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: const Text(
                "Your army is at max capacity, and you have multiple specialisation choices:",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))),
              child: Column(
                children: [
                  ArmyHeader(army: widget.army, iconSize: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  ArmyBody(army: widget.army, iconSize: 20),
                ],
              ),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButton(
                underline: const SizedBox.shrink(),
                borderRadius: BorderRadius.circular(5),
                value: dropdownValue,
                items: widget.army.getMajorityUnit().map((type) {
                  return DropdownMenuItem(
                      value: type,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          IconAndText(
                            text: type.name,
                            icon: unitTypeToIcon(type),
                            iconSize: 16,
                          ),
                        ],
                      ));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    text: "Save",
                    onPressed: () {
                      setState(() {
                        widget.army.specType = dropdownValue;
                        widget.onSave(widget.army);
                      });
                      Navigator.of(context).pop();
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
