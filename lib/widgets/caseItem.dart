import 'package:clicker/styles/fonts.dart';
import 'package:clicker/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CaseWin extends StatelessWidget {
  double win;
  final color;

  CaseWin({required this.win, this.color});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CardContainer(
        color: color,
        child: Center(
          child: Text(
            win.toStringAsFixed(0).split('').reversed.join().replaceAll('000', 'k').split('').reversed.join(),
            style: kShopWhiteText,
          ),
        ),
      ),
    );
  }
}
