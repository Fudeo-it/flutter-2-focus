import 'package:flutter/material.dart';

class BottomAppBarItem extends StatelessWidget {
  final IconData? icon;
  final bool selected;
  final int? count;
  final VoidCallback? onTap;

  const BottomAppBarItem({
    Key? key,
    required this.icon,
    this.selected = false,
    this.count,
    this.onTap,
  }) : super(key: key);

  factory BottomAppBarItem.spacer() => const BottomAppBarItem(icon: null);

  @override
  Widget build(BuildContext context) => Expanded(
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(4),
            height: 50,
            child: icon != null
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      _icon(context),
                      if (selected) _selectedDecorator(context),
                      if (count != null) _count(context),
                    ],
                  )
                : null,
          ),
        ),
      );

  Widget _icon(BuildContext context) => Icon(
        icon,
        color: selected ? Theme.of(context).primaryColor : Colors.grey,
      );

  Widget _selectedDecorator(BuildContext context) => Positioned(
        bottom: 0,
        child: Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );

  Widget _count(BuildContext context) => Positioned(
        top: 4,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          width: 16,
          height: 16,
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 8,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}
