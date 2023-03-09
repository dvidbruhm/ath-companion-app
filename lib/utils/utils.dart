import 'dart:convert';
import 'dart:math';

import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:flutter/material.dart';

typedef ArmyCallback = void Function(Army army);
typedef BoolCallback = void Function(bool value);
String jsonInput = "";

void loadJsonData(BuildContext context) async {
  jsonInput = await DefaultAssetBundle.of(context)
      .loadString("assets/roman_names.json");
}

String getGeneralName() {
  Random rng = Random();
  //String input = File("assets/roman_names.json").readAsStringSync();
  dynamic names = jsonDecode(jsonInput);

  String firstName;
  String lastName;

  switch (rng.nextInt(2)) {
    case 0:
      firstName =
          names["nomens"]["male"][rng.nextInt(names["nomens"]["male"].length)];
      lastName = names["cognomens"]["male"]
          [rng.nextInt(names["cognomens"]["male"].length)];
      break;
    case 1:
      firstName = names["nomens"]["female"]
          [rng.nextInt(names["nomens"]["female"].length)];
      lastName = names["cognomens"]["female"]
          [rng.nextInt(names["cognomens"]["female"].length)];
      break;
    default:
      firstName = "Error";
      lastName = "Error";
  }
  return "$firstName $lastName";
}

IconData unitTypeToIcon(UnitType type) {
  switch (type) {
    case UnitType.sword:
      return GameIcons.broadsword;
    case UnitType.archer:
      return GameIcons.crossbow;
    case UnitType.spear:
      return GameIcons.spear_head;
    case UnitType.horse:
      return GameIcons.horse_head;
    case UnitType.grenadier:
      return GameIcons.bomb;
    case UnitType.catapult:
      return GameIcons.tower;
    case UnitType.none:
      return Icons.hide_source;
  }
}
