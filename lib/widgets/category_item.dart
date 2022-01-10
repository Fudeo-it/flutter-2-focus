import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData? icon;
  final bool selected;

  const CategoryItem(
    this.name, {
    Key? key,
    this.icon,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.onSecondary,
        ),
        child: Row(
          children: [
            if (icon != null)
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? Colors.white : null,
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: selected ? Colors.white : null),
              ),
            ),
          ],
        ),
      );
}
