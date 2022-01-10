import 'package:flutter/material.dart';
import 'package:food_delivery/mocks.dart';
import 'package:food_delivery/widgets/category_item.dart';
import 'package:food_delivery/widgets/food_item.dart';

enum Flavor {
  FOODIE,
  VEGGIE,
}

extension FlavorName on Flavor {
  String get name => this.toString().split('.').last;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.FOODIE:
        return 'Foodie App';
      case Flavor.VEGGIE:
        return 'Veggie App';
      default:
        return 'title';
    }
  }

  static Color? get primaryColor =>
      appFlavor == Flavor.FOODIE ? Colors.red[700] : Colors.green[700];

  static Color? get primaryColorDark =>
      appFlavor == Flavor.FOODIE ? Colors.red[900] : Colors.green[900];

  static Color? get secondaryColor =>
      appFlavor == Flavor.FOODIE ? Colors.orangeAccent[100] : Colors.green[300];

  static String get fontFamily => appFlavor == Flavor.FOODIE
      ? "Pushster" : "JosefinSans";

  static String get splash => appFlavor == Flavor.FOODIE
      ? "assets/images/splash.jpeg"
      : "assets/veggie/images/splash.jpeg";

  static String get onTheWay => appFlavor == Flavor.FOODIE
      ? "assets/images/on_the_way.png"
      : "assets/veggie/images/on_the_way.png";

  static List<CategoryItem> get categories => appFlavor == Flavor.FOODIE
      ? Mocks.foodieCategories
      : Mocks.veggieCategories;

  static List<FoodItem> get foods => appFlavor == Flavor.FOODIE
      ? Mocks.foodieFoods
      : Mocks.veggieFoods;
}
