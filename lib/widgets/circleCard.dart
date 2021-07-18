import 'package:flutter/material.dart';

class CircleCard extends StatelessWidget {
  final child;
  final color;
  final onPress;

  CircleCard({this.child, this.color, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CircleAvatar(
        child: child,
        backgroundColor: color,
      ),
    );
  }
}
