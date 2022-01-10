import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmedList extends StatelessWidget {
  final Widget child;

  const ShimmedList({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemBuilder: (context, index) => Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey[300] ?? Colors.grey,
      highlightColor: Colors.grey[100] ?? Colors.grey,
    ),
    itemCount: 10,
  );
}
