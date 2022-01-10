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
                      _icon(),
                      if (selected) _selectedDecorator(),
                      if (count != null) _count(),
                    ],
                  )
                : null,
          ),
        ),
      );

  Widget _icon() => Icon(
        icon,
        color: selected ? Colors.red[700] : Colors.grey,
      );

  Widget _selectedDecorator() => Positioned(
        bottom: 0,
        child: Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red[700],
          ),
        ),
      );

  Widget _count() => Positioned(
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
                color: Colors.grey[100],
              ),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red[700],
          ),
        ),
      );
}
