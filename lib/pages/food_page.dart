import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/mocks.dart';
import 'package:food_delivery/widgets/food_app_bar.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: FoodAppBar(
          child: _appBar(context),
          blur: false,
        ),
        body: Container(
          color: Colors.orangeAccent[100],
          child: Stack(
            children: [
              _body(context),
              _image(),
            ],
          ),
        ),
      );

  Widget _body(BuildContext context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              _quantityPicker(context),
              _titleAndPrice(context),
              _details(),
              _description(context),
              _action(),
            ],
          ),
        ),
      );

  Widget _quantityPicker(BuildContext context) => Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: Colors.red[700],
        ),
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove,
              size: 16,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '1',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.grey[100],
                    ),
              ),
            ),
            Icon(
              Icons.add,
              size: 16,
              color: Colors.grey[100],
            ),
          ],
        ),
      );

  Widget _titleAndPrice(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Mocks.foods.first.name,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    Mocks.foods.first.description,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '€ ',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                children: [
                  TextSpan(
                    text: Mocks.foods.first.price,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _details() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconAndTextWidget(
              text: '4.8',
              icon: FontAwesomeIcons.solidStar,
              iconColor: Colors.yellow,
            ),
            _iconAndTextWidget(
              text: '150 Kcal',
              icon: FontAwesomeIcons.fire,
              iconColor: Colors.orange,
            ),
            _iconAndTextWidget(
              text: '5-10 Min',
              icon: FontAwesomeIcons.clock,
              iconColor: Colors.red,
            ),
          ],
        ),
      );

  Widget _iconAndTextWidget({
    required String text,
    required IconData icon,
    required Color iconColor,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  Widget _description(BuildContext context) => RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: Mocks.foods.first.caption,
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
          children: [
            TextSpan(
              text: 'Mostra altro',
              style: TextStyle(
                color: Colors.red[700],
              ),
            ),
          ],
        ),
      );

  Widget _action() => Container(
        margin: const EdgeInsets.only(top: 24),
        width: double.maxFinite,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 64,
            ),
            primary: Colors.red[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: () {},
          child: const Text('Aggiungi al carrello'),
        ),
      );

  Widget _image() => Positioned(
        top: 56,
        left: 24,
        right: 24,
        child: Image.asset(Mocks.foods.first.image),
      );

  Widget _appBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                FontAwesomeIcons.chevronLeft,
                size: 16,
              ),
              padding: const EdgeInsets.all(8),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.more_horiz,
              size: 16,
            ),
            padding: const EdgeInsets.all(8),
          ),
        ],
      );
}
