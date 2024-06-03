class NutrientsModel {
  String? calories;
  String? carbs;
  String? fat;
  String? protein;
  List<Bad>? bad;
  List<Good>? good;
  List<Nutrients>? nutrients;
  List<Properties>? properties;
  List<Flavonoids>? flavonoids;
  List<Ingredients>? ingredients;
  CaloricBreakdown? caloricBreakdown;
  WeightPerServing? weightPerServing;
  int? expires;

  NutrientsModel({
    this.calories,
    this.carbs,
    this.fat,
    this.protein,
    this.bad,
    this.good,
    this.nutrients,
    this.properties,
    this.flavonoids,
    this.ingredients,
    this.caloricBreakdown,
    this.weightPerServing,
    this.expires,
  });

  NutrientsModel.fromJson(Map<String, dynamic> json) {
    calories = json['calories'] as String?;
    carbs = json['carbs'] as String?;
    fat = json['fat'] as String?;
    protein = json['protein'] as String?;
    bad = (json['bad'] as List?)
        ?.map((dynamic e) => Bad.fromJson(e as Map<String, dynamic>))
        .toList();
    good = (json['good'] as List?)
        ?.map((dynamic e) => Good.fromJson(e as Map<String, dynamic>))
        .toList();
    nutrients = (json['nutrients'] as List?)
        ?.map((dynamic e) => Nutrients.fromJson(e as Map<String, dynamic>))
        .toList();
    properties = (json['properties'] as List?)
        ?.map((dynamic e) => Properties.fromJson(e as Map<String, dynamic>))
        .toList();
    flavonoids = (json['flavonoids'] as List?)
        ?.map((dynamic e) => Flavonoids.fromJson(e as Map<String, dynamic>))
        .toList();
    ingredients = (json['ingredients'] as List?)
        ?.map((dynamic e) => Ingredients.fromJson(e as Map<String, dynamic>))
        .toList();
    caloricBreakdown =
        (json['caloricBreakdown'] as Map<String, dynamic>?) != null
            ? CaloricBreakdown.fromJson(
                json['caloricBreakdown'] as Map<String, dynamic>)
            : null;
    weightPerServing =
        (json['weightPerServing'] as Map<String, dynamic>?) != null
            ? WeightPerServing.fromJson(
                json['weightPerServing'] as Map<String, dynamic>)
            : null;
    expires = json['expires'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['calories'] = calories;
    json['carbs'] = carbs;
    json['fat'] = fat;
    json['protein'] = protein;
    json['bad'] = bad?.map((e) => e.toJson()).toList();
    json['good'] = good?.map((e) => e.toJson()).toList();
    json['nutrients'] = nutrients?.map((e) => e.toJson()).toList();
    json['properties'] = properties?.map((e) => e.toJson()).toList();
    json['flavonoids'] = flavonoids?.map((e) => e.toJson()).toList();
    json['ingredients'] = ingredients?.map((e) => e.toJson()).toList();
    json['caloricBreakdown'] = caloricBreakdown?.toJson();
    json['weightPerServing'] = weightPerServing?.toJson();
    json['expires'] = expires;
    return json;
  }
}

class Bad {
  String? title;
  String? amount;
  bool? indented;
  double? percentOfDailyNeeds;

  Bad({
    this.title,
    this.amount,
    this.indented,
    this.percentOfDailyNeeds,
  });

  Bad.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    amount = json['amount'] as String?;
    indented = json['indented'] as bool?;
    percentOfDailyNeeds = json['percentOfDailyNeeds'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['amount'] = amount;
    json['indented'] = indented;
    json['percentOfDailyNeeds'] = percentOfDailyNeeds;
    return json;
  }
}

class Good {
  String? title;
  String? amount;
  bool? indented;
  double? percentOfDailyNeeds;

  Good({
    this.title,
    this.amount,
    this.indented,
    this.percentOfDailyNeeds,
  });

  Good.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    amount = json['amount'] as String?;
    indented = json['indented'] as bool?;
    percentOfDailyNeeds = json['percentOfDailyNeeds'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['amount'] = amount;
    json['indented'] = indented;
    json['percentOfDailyNeeds'] = percentOfDailyNeeds;
    return json;
  }
}

class Nutrients {
  String? name;
  double? amount;
  String? unit;
  double? percentOfDailyNeeds;

  Nutrients({
    this.name,
    this.amount,
    this.unit,
    this.percentOfDailyNeeds,
  });

  Nutrients.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    amount = json['amount'] as double?;
    unit = json['unit'] as String?;
    percentOfDailyNeeds = json['percentOfDailyNeeds'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    json['percentOfDailyNeeds'] = percentOfDailyNeeds;
    return json;
  }
}

class Properties {
  String? name;
  double? amount;
  String? unit;

  Properties({
    this.name,
    this.amount,
    this.unit,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    amount = json['amount'] as double?;
    unit = json['unit'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    return json;
  }
}

class Flavonoids {
  String? name;
  num? amount;
  String? unit;

  Flavonoids({
    this.name,
    this.amount,
    this.unit,
  });

  Flavonoids.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    amount = json['amount'];
    unit = json['unit'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    return json;
  }
}

class Ingredients {
  int? id;
  String? name;
  double? amount;
  String? unit;
  List<Nutrients>? nutrients;

  Ingredients({
    this.id,
    this.name,
    this.amount,
    this.unit,
    this.nutrients,
  });

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    amount = json['amount'] as double?;
    unit = json['unit'] as String?;
    nutrients = (json['nutrients'] as List?)
        ?.map((dynamic e) => Nutrients.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    json['nutrients'] = nutrients?.map((e) => e.toJson()).toList();
    return json;
  }
}

// class Nutrients {
//   String? name;
//   double? amount;
//   String? unit;
//   double? percentOfDailyNeeds;

//   Nutrients({
//     this.name,
//     this.amount,
//     this.unit,
//     this.percentOfDailyNeeds,
//   });

//   Nutrients.fromJson(Map<String, dynamic> json) {
//     name = json['name'] as String?;
//     amount = json['amount'] as double?;
//     unit = json['unit'] as String?;
//     percentOfDailyNeeds = json['percentOfDailyNeeds'] as double?;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> json = <String, dynamic>{};
//     json['name'] = name;
//     json['amount'] = amount;
//     json['unit'] = unit;
//     json['percentOfDailyNeeds'] = percentOfDailyNeeds;
//     return json;
//   }
// }

class CaloricBreakdown {
  double? percentProtein;
  double? percentFat;
  double? percentCarbs;

  CaloricBreakdown({
    this.percentProtein,
    this.percentFat,
    this.percentCarbs,
  });

  CaloricBreakdown.fromJson(Map<String, dynamic> json) {
    percentProtein = json['percentProtein'] as double?;
    percentFat = json['percentFat'] as double?;
    percentCarbs = json['percentCarbs'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['percentProtein'] = percentProtein;
    json['percentFat'] = percentFat;
    json['percentCarbs'] = percentCarbs;
    return json;
  }
}

class WeightPerServing {
  int? amount;
  String? unit;

  WeightPerServing({
    this.amount,
    this.unit,
  });

  WeightPerServing.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] as int?;
    unit = json['unit'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['amount'] = amount;
    json['unit'] = unit;
    return json;
  }
}
