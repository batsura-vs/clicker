import 'dart:math';

import 'package:clicker/styles/fonts.dart';
import 'package:clicker/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinCrash extends StatefulWidget {
  final balance;
  final bonus;

  CoinCrash({this.balance, this.bonus});

  @override
  _CoinCrashState createState() => _CoinCrashState();
}

class _CoinCrashState extends State<CoinCrash> {
  var state = 1;
  var ko = 0.0;
  var color = Colors.green;
  var started = false;
  var st = false;
  dynamic win;
  List<Coef> game = [Coef(x: '0', y: 31)];

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = '0';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  startGame() async {
    var random = Random();
    var obr = random.nextInt(30) + 1;
    var z = 0;
    started = true;
    while (started && ko < obr) {
      setState(() {
        game.add(Coef(x: z.toString(), y: ko));
      });
      ko += z / 100;
      await Future.delayed(Duration(milliseconds: 50));
      z++;
    }
    if (ko >= obr && started) {
      setState(() {
        color = Colors.red;
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        state = 5;
      });
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context,
          [widget.balance - double.parse(_controller.text), widget.bonus]);
    } else {
      win = ko;
    }
    started = false;
  }

  stop() async {
    started = false;
    setState(() {
      color = Colors.blue;
    });
    st = true;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      state = 4;
    });
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context, [widget.balance + (double.parse(_controller.text) * win), widget.bonus]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[600],
      appBar: AppBar(
        title: Text('Coin Crash'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: state == 3,
            child: Expanded(
              child: CardContainer(
                color: Colors.blueGrey[600],
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    isTransposed: false,
                    plotAreaBorderWidth: 0,
                    enableAxisAnimation: true,
                    title: ChartTitle(text: '${ko.toStringAsFixed(1)}x'),
                    // Enable legend
                    plotAreaBackgroundColor: Colors.grey[700],
                    legend: Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(enable: false),
                    // Enable tooltip
                    series: <ChartSeries<Coef, String>>[
                      LineSeries<Coef, String>(
                        dataSource: game,
                        xValueMapper: (Coef c, _) => c.x,
                        yValueMapper: (Coef c, _) => c.y,
                        color: Colors.green,
                        name: 'x',
                      )
                    ]),
              ),
            ),
          ),
          Visibility(
            visible: state == 1,
            child: Expanded(
              flex: 2,
              child: Container(
                color: Colors.indigo[600],
                child: Column(
                  children: [
                    Expanded(
                      child: CardContainer(
                        child: Center(
                          child: Text(
                            widget.balance.toStringAsFixed(3),
                            textAlign: TextAlign.center,
                            style: kBigWhiteText,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            (widget.balance / 100 * 10)
                                                .toStringAsFixed(3);
                                      },
                                      child: CardContainer(
                                        color: Color(0xff5c5858),
                                        child: Text(
                                          '10%',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            (widget.balance / 100 * 50)
                                                .toStringAsFixed(3);
                                      },
                                      child: CardContainer(
                                        color: Color(0xff5c5858),
                                        child: Text(
                                          '50%',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            (widget.balance).toStringAsFixed(3);
                                      },
                                      child: CardContainer(
                                        color: Color(0xff5c5858),
                                        child: Text(
                                          '100%',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            (double.parse(_controller.text) +
                                                    100)
                                                .toStringAsFixed(3);
                                      },
                                      child: CardContainer(
                                        color: Color(0xff5c5858),
                                        child: Text(
                                          '+100',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            (double.parse(_controller.text) +
                                                    10000)
                                                .toStringAsFixed(3);
                                      },
                                      child: CardContainer(
                                        color: Color(0xff5c5858),
                                        child: Text(
                                          '+10k',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            (double.parse(_controller.text) +
                                                    100000)
                                                .toStringAsFixed(3);
                                      },
                                      child: CardContainer(
                                        color: Color(0xff5c5858),
                                        child: Text(
                                          '+100k',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: kWhiteText,
                                    readOnly: true,
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText:
                                          'Введите сколько хотите поставить',
                                    ),
                                  ),
                                ),
                                Card(
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.text = '0';
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.balance >
                                      double.parse(_controller.text)) {
                                    state = 2;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Не хватает!')));
                                  }
                                });
                              },
                              child: Container(
                                color: Colors.pink[600],
                                child: Center(
                                  child: Text(
                                    'Играть',
                                    style: kShopWhiteText,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: state == 2,
            child: Expanded(
              flex: 2,
              child: CardContainer(
                color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Visibility(
                        visible: state == 2,
                        child: Center(
                          child: Text(
                            'Вы ставите: ${_controller.text}\nВсё верно?',
                            textAlign: TextAlign.center,
                            style: kShopWhiteText,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state == 2,
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  state = 1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.red,
                                child: Center(
                                    child: Text(
                                  'Назад',
                                  style: kShopWhiteText,
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  state = 3;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.green[700],
                                child: Center(
                                    child: Text(
                                  'Начали',
                                  style: kShopWhiteText,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: state == 3,
            child: Expanded(
              flex: 2,
              child: CardContainer(
                color: color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                          child: CardContainer(
                        color: Colors.black38,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            ko.toStringAsFixed(1),
                            style: kBigWhiteText,
                          ),
                        ),
                      )),
                    ),
                    Visibility(
                      visible: (!started && (state == 3) && (!st)),
                      child: Expanded(
                        child: GestureDetector(
                          onTap: startGame,
                          child: CardContainer(
                            color: Colors.green[700],
                            child: Center(
                              child: Text(
                                'Старт',
                                style: kShopWhiteText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: started,
                      child: Expanded(
                        child: GestureDetector(
                          onTap: stop,
                          child: CardContainer(
                            color: Colors.redAccent[700],
                            child: Center(
                              child: Text(
                                'Стоп',
                                style: kShopWhiteText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: state == 4,
            child: Expanded(
              child: CardContainer(
                color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Победа! ваш выигрышь: ${win != null ? win.toStringAsFixed(1) : 0}x',
                      textAlign: TextAlign.center,
                      style: kShopWhiteText,
                    ))
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: state == 5,
            child: Expanded(
              child: CardContainer(
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Вы проиграли: ${_controller.text}',
                      textAlign: TextAlign.center,
                      style: kShopWhiteText,
                    ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Coef {
  final x;
  final y;

  Coef({this.x, this.y});
}
