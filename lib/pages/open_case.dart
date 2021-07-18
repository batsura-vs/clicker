import 'package:clicker/styles/fonts.dart';
import 'package:clicker/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CasePage extends StatefulWidget {
  final name;
  final cost;
  var balance;
  final color;
  final items;
  final bonus;

  CasePage(
      this.name, this.cost, this.color, this.balance, this.items, this.bonus);

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  late var item0 = widget.items[0];
  late var item1 = widget.items[1];
  late var item2 = widget.items[2];
  var win = '';
  var spinning = false;

  spin() async {
    if (widget.cost <= widget.balance) {
      var rand = Random();
      dynamic sp = rand.nextInt((widget.items.length)) + 25;
      var now = 2;
      var rep = 0;
      while (rep < sp) {
        setState(() {
          spinning = true;
          item0 = item1;
          item1 = item2;
          if (now < widget.items.length - 1) {
            now++;
          } else {
            now = 0;
          }
          item2 = widget.items[now];
          rep++;
        });
        await Future.delayed(Duration(milliseconds: 10 + rep * 10));
      }
      setState(() {
        win = '${item1.win}';
      });
      await Future.delayed(Duration(milliseconds: 2000));
      Navigator.pop(
          context, [widget.balance + item1.win - widget.cost, widget.bonus]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не хватает: ${widget.cost - widget.balance}')));
    }
  }

  buy() {
    if (widget.cost <= widget.balance) {
      spin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Открыть кейс'),
      ),
      body: Container(
        color: Colors.green[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Container(
                    child: Center(
                        child: Text(
                      [for (var i in widget.items) num.parse(i.win.toString())]
                          .reduce(max)
                          .toStringAsFixed(3),
                      style: kBigWhiteText,
                    )),
                    height: constraint.biggest.height,
                    decoration: BoxDecoration(
                        color: widget.color,
                        image: DecorationImage(
                            image: AssetImage('assets/box.png')),
                        borderRadius: BorderRadius.circular(10)),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.blueGrey[400],
                    child: Row(
                      children: [
                        Expanded(
                        child: Container(
                          child: item0,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[700],
                              border: Border.all(color: Colors.grey)),
                        ),
                      ),
                        Expanded(
                          child: Container(
                            child: item1,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[700],
                                border: Border.all(color: Colors.yellow)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: item2,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[700],
                                border: Border.all(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      win,
                      style: kBigWhiteText,
                    ),
                  ),
                  GestureDetector(
                    onTap: spin,
                    child: Visibility(
                      visible: !spinning,
                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            color: widget.color,
                            width: constraint.biggest.width,
                            child: Center(
                              child: Text(
                                'Открыть за: ${widget.cost.toStringAsFixed(3)}',
                                style: kWhiteText,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
