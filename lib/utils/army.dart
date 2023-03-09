import 'package:bgame_app/utils/params.dart' as game_params;
import 'package:bgame_app/utils/params.dart';

enum UnitType { sword, archer, spear, horse, grenadier, catapult, none }

class UnitStatPair {
  final UnitType type;
  final int stat;
  const UnitStatPair(this.type, this.stat);
  @override
  String toString() {
    return "type: ${type.name}, stat : $stat";
  }
}

class Army {
  int armyNb,
      nbSwords,
      nbArchers,
      nbSpears,
      nbHorses,
      nbGrenadiers,
      nbCatapults;
  String generalName;
  UnitType specType = UnitType.none;
  bool hidden = false;
  bool down = false;
  Army(this.armyNb, this.generalName, this.nbSwords, this.nbArchers,
      this.nbSpears, this.nbHorses, this.nbGrenadiers, this.nbCatapults);

  int getTotalFood() {
    return getSwordStats().food * nbSwords +
        getSpearStats().food * nbSpears +
        getArcherStats().food * nbArchers +
        getHorseStats().food * nbHorses +
        game_params.grenadierStats.food * nbGrenadiers +
        game_params.catapultStats.food * nbCatapults;
  }

  int getTotalDmg() {
    return getSwordStats().dmg * nbSwords +
        getSpearStats().dmg * nbSpears +
        getArcherStats().dmg * nbArchers +
        getHorseStats().dmg * nbHorses +
        game_params.grenadierStats.dmg * nbGrenadiers +
        game_params.catapultStats.dmg * nbCatapults;
  }

  int getTotalLife() {
    return getSwordStats().life * nbSwords +
        getSpearStats().life * nbSpears +
        getArcherStats().life * nbArchers +
        getHorseStats().life * nbHorses +
        game_params.grenadierStats.life * nbGrenadiers +
        game_params.catapultStats.life * nbCatapults;
  }

  List<UnitType> getMajorityUnit() {
    if (getTotalFood() == 0) {
      return [UnitType.none];
    }

    List<UnitStatPair> foods = [
      UnitStatPair(UnitType.sword, getSwordStats().food * nbSwords),
      UnitStatPair(UnitType.spear, getSpearStats().food * nbSpears),
      UnitStatPair(UnitType.archer, getArcherStats().food * nbArchers),
      UnitStatPair(UnitType.horse, getHorseStats().food * nbHorses),
      UnitStatPair(
          UnitType.grenadier, game_params.grenadierStats.food * nbGrenadiers),
      UnitStatPair(
          UnitType.catapult, game_params.catapultStats.food * nbCatapults)
    ];
    foods.sort((a, b) => b.stat.compareTo(a.stat));
    foods = foods.where((element) => element.stat >= foods[0].stat).toList();
    var majorityTypes = foods.map((e) => e.type).toList();
    return majorityTypes;
  }

  UnitStats getSwordStats() {
    return UnitStats(
        game_params.swordStats.life +
            ((specType == UnitType.sword)
                ? game_params.swordSpecBonus.life
                : 0),
        game_params.swordStats.dmg +
            ((specType == UnitType.sword) ? game_params.swordSpecBonus.dmg : 0),
        game_params.swordStats.food);
  }

  UnitStats getArcherStats() {
    return UnitStats(
        game_params.archerStats.life +
            ((specType == UnitType.archer)
                ? game_params.archerSpecBonus.life
                : 0),
        game_params.archerStats.dmg +
            ((specType == UnitType.archer)
                ? game_params.archerSpecBonus.dmg
                : 0),
        game_params.archerStats.food);
  }

  UnitStats getSpearStats() {
    return UnitStats(
        game_params.spearStats.life +
            ((specType == UnitType.spear)
                ? game_params.spearSpecBonus.life
                : 0),
        game_params.spearStats.dmg +
            ((specType == UnitType.spear) ? game_params.spearSpecBonus.dmg : 0),
        game_params.spearStats.food);
  }

  UnitStats getHorseStats() {
    return UnitStats(
        game_params.horseStats.life +
            ((specType == UnitType.horse)
                ? game_params.horseSpecBonus.life
                : 0),
        game_params.horseStats.dmg +
            ((specType == UnitType.horse) ? game_params.horseSpecBonus.dmg : 0),
        game_params.horseStats.food);
  }
}
