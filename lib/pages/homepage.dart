import 'package:bgame_app/game_icons_icons.dart';
import 'package:bgame_app/pages/choose_spec_dialog.dart';
import 'package:bgame_app/pages/edit_army_dialog.dart';
import 'package:bgame_app/pages/research_dialog.dart';
import 'package:bgame_app/pages/spy_dialog.dart';
import 'package:bgame_app/utils/army.dart';
import 'package:bgame_app/utils/button.dart';
import 'package:flutter/material.dart';
import '../utils/army_tile.dart';
import '../utils/utils.dart';
import '../utils/params.dart' as game_params;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadJsonData(context);
  }

  List<Army> armies = [];
  var unitInputControllers = {
    "sword": TextEditingController(),
    "archer": TextEditingController(),
    "spear": TextEditingController(),
    "horse": TextEditingController(),
    "grenadier": TextEditingController(),
    "catapult": TextEditingController(),
  };
  var spyController = TextEditingController();
  bool beingSpied = false;
  bool specResearch = false;

  bool saveArmyGetInput = true;
  bool chooseSpecDialog = false;

  void saveResearch(bool value) {
    setState(() {
      saveArmyGetInput = false;
      specResearch = value;
    });

    for (var a in armies) {
      saveArmy(a);
    }

    setState(() {
      saveArmyGetInput = true;
    });
    if (!chooseSpecDialog) {
      //Navigator.of(context).pop();
    }
  }

  void spyDialog() {
    spyController.text = armies.isNotEmpty ? "${armies[0].armyNb}" : "0";
    showDialog(
      context: context,
      builder: (context) {
        return SpyDialog(
          spyController: spyController,
          onSave: blurArmies,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void blurArmies() {
    int armyNbToShow = int.parse(spyController.text);
    bool valid = false;
    for (var army in armies) {
      if (army.armyNb == armyNbToShow) valid = true;
    }

    if (!valid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: SizedBox(
                height: 70,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Army number must be valid."),
                        Button(
                            text: "Ok",
                            onPressed: (() => Navigator.of(context).pop()),
                            color: Colors.red[700])
                      ]),
                ),
              ),
            );
          });
      return;
    }
    setState(() {
      beingSpied = true;
      for (var army in armies) {
        if (army.armyNb != armyNbToShow) {
          army.hidden = true;
        }
      }
    });
    Navigator.of(context).pop();
  }

  void unblurArmies() {
    setState(() {
      beingSpied = false;
      for (var army in armies) {
        army.hidden = false;
      }
    });
  }

  void addArmy() {
    setState(() {
      int firstEmptyArmyNb = 1;
      for (var army in armies) {
        if (army.armyNb != firstEmptyArmyNb) {
          break;
        }
        firstEmptyArmyNb++;
      }

      armies.insert(firstEmptyArmyNb - 1,
          Army(firstEmptyArmyNb, getGeneralName(), 0, 0, 0, 0, 0, 0));
      armies.sort(((a, b) => a.armyNb.compareTo(b.armyNb)));
    });
  }

  void saveArmy(Army army) {
    chooseSpecDialog = false;

    Army updatedArmy = Army(
        army.armyNb,
        army.generalName,
        army.nbSwords,
        army.nbArchers,
        army.nbSpears,
        army.nbHorses,
        army.nbGrenadiers,
        army.nbCatapults);
    updatedArmy.specType = specResearch ? army.specType : UnitType.none;

    if (saveArmyGetInput) {
      updatedArmy.nbSwords = int.parse(unitInputControllers["sword"]?.text == ""
          ? "0"
          : unitInputControllers["sword"]?.text ?? "");
      updatedArmy.nbArchers = int.parse(
          unitInputControllers["archer"]?.text == ""
              ? "0"
              : unitInputControllers["archer"]?.text ?? "");
      updatedArmy.nbSpears = int.parse(unitInputControllers["spear"]?.text == ""
          ? "0"
          : unitInputControllers["spear"]?.text ?? "");
      updatedArmy.nbHorses = int.parse(unitInputControllers["horse"]?.text == ""
          ? "0"
          : unitInputControllers["horse"]?.text ?? "");
      updatedArmy.nbGrenadiers = int.parse(
          unitInputControllers["grenadier"]?.text == ""
              ? "0"
              : unitInputControllers["grenadier"]?.text ?? "");
      updatedArmy.nbCatapults = int.parse(
          unitInputControllers["catapult"]?.text == ""
              ? "0"
              : unitInputControllers["catapult"]?.text ?? "");
    }

    if (updatedArmy.getTotalFood() > game_params.maxArmyFood) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: SizedBox(
                height: 70,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                            "Army has too much food. (max ${game_params.maxArmyFood})"),
                        Button(
                            text: "Ok",
                            onPressed: (() => Navigator.of(context).pop()),
                            color: Colors.red[700])
                      ]),
                ),
              ),
            );
          });
      return;
    }

    // Specialisation bonuses and selection
    if (specResearch) {
      if (updatedArmy.getTotalFood() == game_params.maxArmyFood &&
          updatedArmy.specType == UnitType.none) {
        var majorityUnits = updatedArmy.getMajorityUnit();
        if (majorityUnits.length == 1) {
          updatedArmy.specType = majorityUnits[0];
        } else {
          chooseSpecDialog = true;
          showDialog(
            context: context,
            builder: (context) {
              return ChooseSpecDialog(
                army: updatedArmy,
                onSave: (Army army) {
                  saveArmy(army);
                  //Navigator.of(context).pop();
                },
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          );
          return;
        }
      }
    }

    if (updatedArmy.specType != UnitType.none &&
        updatedArmy.getTotalFood() < game_params.foodBeforeSpecStops) {
      updatedArmy.specType = UnitType.none;
    }

    int findArmy(int armyNb) => armies.indexWhere((a) => a.armyNb == armyNb);
    setState(() {
      int armyToEdit = findArmy(army.armyNb);
      armies[armyToEdit] = updatedArmy;
    });
    if (saveArmyGetInput) {
      //Navigator.of(context).pop();
    }
  }

  void deleteArmy(Army army) {
    setState(() {
      armies.remove(army);
    });
  }

  void editArmy(Army army) {
    unitInputControllers["sword"]?.text = army.nbSwords.toString();
    unitInputControllers["archer"]?.text = army.nbArchers.toString();
    unitInputControllers["spear"]?.text = army.nbSpears.toString();
    unitInputControllers["horse"]?.text = army.nbHorses.toString();
    unitInputControllers["grenadier"]?.text = army.nbGrenadiers.toString();
    unitInputControllers["catapult"]?.text = army.nbCatapults.toString();
    showDialog(
      context: context,
      builder: (context) {
        return EditArmyDialog(
            army: army,
            controllers: unitInputControllers,
            onSave: saveArmy,
            onCancel: () => Navigator.of(context).pop());
      },
    );
  }

  void researchDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return ResearchDialog(
            onSave: saveResearch,
            onCancel: () => Navigator.of(context).pop(),
            specResearch: specResearch,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("ATH - Companion app")),
          elevation: 0,
        ),
        floatingActionButton: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: FloatingActionButton(
                backgroundColor: Colors.blue[600],
                onPressed: researchDialog,
                child: const Icon(size: 30, GameIcons.round_bottom_flask),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FloatingActionButton(
                backgroundColor:
                    beingSpied ? Colors.red[500] : Colors.green[600],
                onPressed: () {
                  if (beingSpied) {
                    unblurArmies();
                  } else {
                    spyDialog();
                  }
                },
                child: const Icon(size: 30, GameIcons.cloak_and_dagger),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: FloatingActionButton(
                backgroundColor: Colors.cyan[800],
                onPressed: addArmy,
                child: Row(children: const [
                  Spacer(),
                  Text("+"),
                  Icon(GameIcons.helmet),
                  Spacer()
                ]),
              ),
            )
          ],
        ),
        body: DefaultTextStyle(
          style: const TextStyle(fontSize: 16),
          child: ListView.builder(
            itemCount: armies.length,
            itemBuilder: (context, index) {
              return ArmyTile(
                army: armies[index],
                onLongPress: editArmy,
                onDelete: deleteArmy,
              );
            },
          ),
        ));
  }
}
