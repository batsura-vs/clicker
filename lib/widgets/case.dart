import 'package:clicker/pages/open_case.dart';
import 'package:flutter/material.dart';

class CaseItem extends StatelessWidget {
  final title;
  final cost;
  final color;
  final bonus;
  var onPress;
  final items;
  final balance;

  CaseItem({
    this.title,
    this.cost,
    this.color,
    this.bonus,
    this.onPress,
    this.balance,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        leading: cost > balance
            ? Icon(
                Icons.error,
                color: Colors.red,
                size: 40,
              )
            : Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
        title: Text('$title - ${cost.toStringAsFixed(3)}'),
        enabled: cost > balance ? false : true,
        trailing: GestureDetector(
          onTap: () => onPress(title, cost, color, balance, items, bonus),
          child: Icon(
            Icons.open_in_new,
            size: 40,
          ),
        ),
      ),
    );
  }
}
