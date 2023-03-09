const int maxArmyFood = 15;
const int foodBeforeSpecStops = 8;

class UnitStats {
  final int food, life, dmg;
  const UnitStats(this.life, this.dmg, this.food);
}

const UnitStats swordStats = UnitStats(4, 1, 1);
const UnitStats archerStats = UnitStats(2, 3, 1);
const UnitStats spearStats = UnitStats(3, 2, 1);
const UnitStats horseStats = UnitStats(4, 4, 2);
const UnitStats grenadierStats = UnitStats(1, 8, 1);
const UnitStats catapultStats = UnitStats(4, 12, 3);

const UnitStats swordSpecBonus = UnitStats(2, 0, 0);
const UnitStats spearSpecBonus = UnitStats(1, 1, 0);
const UnitStats archerSpecBonus = UnitStats(0, 2, 0);
const UnitStats horseSpecBonus = UnitStats(1, 2, 0);
