import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

part 'food_item.g.dart';

@CopyWith()
class FoodItem extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String caption;
  final String price;
  final VoidCallback? onTap;

  const FoodItem({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.caption,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.background,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  image,
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(description,
                      style: Theme.of(context).textTheme.caption),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: '€ ',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                      children: [
                        TextSpan(
                          text: price,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
