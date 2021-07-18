import 'package:flutter/material.dart';

class ShopItem extends StatelessWidget {
  final title;
  final subtitle;
  final cost;
  final bonus;
  final onPress;
  final balance;
  final callback;

  ShopItem(
      {this.title,
        this.subtitle,
        this.cost,
        this.bonus,
        this.onPress,
        this.balance,
        this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
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
        subtitle: Text('$subtitle\n+${bonus.toStringAsFixed(3)} за каждый клик'),
        enabled: cost > balance ? false : true,
        trailing: GestureDetector(
          onTap: () {
            callback != null && cost <= balance ? callback() : false;
            onPress(cost, bonus);
          },
          child: Icon(
            Icons.shopping_cart,
            size: 40,
          ),
        ),
      ),
    );
  }
}