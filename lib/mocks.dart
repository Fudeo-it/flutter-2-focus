import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/widgets/category_item.dart';
import 'package:food_delivery/widgets/food_item.dart';

class Mocks {
  static const foodieCategories = [
    CategoryItem(
      'Hamburger',
      icon: FontAwesomeIcons.hamburger,
      selected: true,
    ),
    CategoryItem(
      'Pizza',
      icon: FontAwesomeIcons.pizzaSlice,
    ),
    CategoryItem(
      'Verdure',
      icon: FontAwesomeIcons.pepperHot,
    ),
  ];

  static const veggieCategories = [
    CategoryItem(
      'Piccante',
      icon: FontAwesomeIcons.pepperHot,
      selected: true,
    ),
    CategoryItem(
      'Arancietà',
      icon: FontAwesomeIcons.carrot,
    ),
    CategoryItem(
      'Verdure',
      icon: FontAwesomeIcons.seedling,
    ),
  ];

  static const foodieFoods = [
    FoodItem(
      image: 'assets/images/hamburger-orig.png',
      name: 'Hamburger di Manzo',
      description: 'Mozzarella al formaggio',
      caption:
          'Questo hamburger di manzo utilizza carne di manzo di qualità al 100% con pomodori a fette, cetrioli, verdure, e cipolle...',
      price: '6.59',
    ),
    FoodItem(
        image: 'assets/images/bacon_king.png',
        name: 'Bacon Burger',
        description: 'Doppio Bacon',
        caption:
            'Questo hamburger di manzo utilizza carne di manzo di qualità al 100% con pomodori a fette, cetrioli, verdure, e cipolle...',
        price: '8.59'),
    FoodItem(
      image: 'assets/images/hamburger-orig.png',
      name: 'Cheese Burger',
      description: 'Cheddar',
      caption:
          'Questo hamburger di manzo utilizza carne di manzo di qualità al 100% con pomodori a fette, cetrioli, verdure, e cipolle...',
      price: '10.59',
    ),
  ];

  static const veggieFoods = [
    FoodItem(
      image: 'assets/veggie/images/salad.png',
      name: 'Insalata',
      description: 'Pomodori rossi',
      caption:
      'Questa insalata utilizza pomodori, cetrioli, verdure e cipolle affettati al 100%',
      price: '10.59',
    ),
    FoodItem(
        image: 'assets/veggie/images/pack-vegan-meal-pack.png',
        name: 'Twisty Burger',
        description: 'Tasty salad',
        caption:
        'Questa insalata utilizza pomodori, cetrioli, verdure e cipolle affettati al 100%',
        price: '8.59'),
    FoodItem(
      image: 'assets/veggie/images/salad.png',
      name: 'Insalata',
      description: 'Pomodori rossi',
      caption:
      'Questa insalata utilizza pomodori, cetrioli, verdure e cipolle affettati al 100%',
      price: '9.99',
    ),
  ];
}
