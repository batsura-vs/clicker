import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final color;
  final child;
  CardContainer({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: child,
    );
  }
}
