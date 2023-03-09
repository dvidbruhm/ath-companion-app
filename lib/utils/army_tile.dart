import 'dart:ui';

import 'package:bgame_app/utils/army_body.dart';
import 'package:bgame_app/utils/army_header.dart';
import 'package:bgame_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:bgame_app/utils/army.dart';

class ArmyTile extends StatefulWidget {
  final Army army;
  final ArmyCallback onLongPress;
  final ArmyCallback onDelete;

  const ArmyTile(
      {super.key,
      required this.army,
      required this.onLongPress,
      required this.onDelete});

  @override
  State<ArmyTile> createState() => _ArmyTileState();
}

class _ArmyTileState extends State<ArmyTile> {
  bool beingPressed = false;
  int duration = 100;
  bool blurred = false;

  final double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              duration = 500;
              beingPressed = false;
            });
            if (!widget.army.down) {
              widget.onLongPress(widget.army);
            }
          },
          onTapDown: (details) {
            if (!widget.army.down) {
              setState(() {
                duration = 100;
                beingPressed = true;
              });
            }
          },
          onTapUp: (details) {
            setState(() {
              duration = 100;
              beingPressed = false;
            });
          },
          onDoubleTap: () {
            setState(() {
              widget.army.down = !widget.army.down;
              beingPressed = false;
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Dismissible(
              background: Container(color: Colors.red[700]),
              key: Key(widget.army.generalName),
              onDismissed: (direction) {
                widget.onDelete(widget.army);
              },
              child: Stack(children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: duration),
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                  decoration: BoxDecoration(
                    color: !beingPressed
                        ? Theme.of(context).cardColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  child: Column(
                    children: [
                      ArmyHeader(army: widget.army, iconSize: iconSize),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: !widget.army.down,
                        child: ArmyBody(army: widget.army, iconSize: iconSize),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: widget.army.hidden ? 5 : 0,
                          sigmaY: widget.army.hidden ? 5 : 0),
                      child: Container(
                        color: Colors.black
                            .withOpacity(widget.army.down ? 0.5 : 0.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
