import 'package:clicker/pages/coin_crash.dart';
import 'package:clicker/pages/open_case.dart';
import 'package:clicker/styles/fonts.dart';
import 'package:clicker/widgets/card_container.dart';
import 'package:clicker/widgets/case.dart';
import 'package:clicker/widgets/caseItem.dart';
import 'package:clicker/widgets/circleCard.dart';
import 'package:clicker/widgets/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:sqlite3/open.dart';

class HomePage extends StatefulWidget {
  final args;

  HomePage({this.args});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bonus = 0.001;
  var clicks = 0.000;
  var items = [];
  var page = 0;
  dynamic shopItem = 0;

  @override
  initState() {
    super.initState();
    setState(() {
      bonus = widget.args[1];
      clicks = widget.args[0];
      shopItem = 0;
    });
  }

  buy(cost, b) {
    if (cost <= clicks) {
      setState(() {
        clicks -= cost;
        bonus += b;
      });
    }
  }

  addShopItem(title, subtitle, cost, bon, index) {
    var now;
    if (index >= items.length - 1) {
      items.add(0);
      now = items.length - 1;
    } else {
      now = index;
    }
    return ShopItem(
      title: title,
      subtitle: subtitle,
      cost: cost * (items[now] + 1),
      balance: clicks,
      bonus: bon,
      onPress: buy,
      callback: () {
        setState(() {
          items[now]++;
        });
      },
    );
  }

  toScreen(title, cost, color, balance, items, bonus) async {
    var arr = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CasePage(title, cost, color, balance, items, bonus),
        ));
    if (arr != null) {
      setState(() {
        this.bonus = arr[1];
        this.clicks = arr[0];
      });
    }
  }

  goToCoinCrash() async {
    var arr = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoinCrash(
            balance: clicks,
            bonus: bonus,
          ),
        ));
    if (arr != null) {
      setState(() {
        this.bonus = arr[1];
        this.clicks = arr[0];
      });
    }
  }

  shop() {
    setState(() {
      shopItem = 0;
    });
  }

  cases() {
    setState(() {
      shopItem = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clicker')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CardContainer(
              color: Colors.lightGreen[400],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: CircleCard(
                      onPress: () {
                        setState(() {
                          clicks += bonus;
                        });
                      },
                      color: Colors.lightGreen[700],
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              clicks.toStringAsFixed(3).split('.').first,
                              style: kBigWhiteText,
                            ),
                            Text(
                              '.',
                              style: kBigWhiteText,
                            ),
                            Text(
                              clicks
                                  .toStringAsFixed(3)
                                  .split('.')
                                  .last
                                  .substring(0, 3),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'За 1 клик:',
                              style: kWhiteText,
                            ),
                            Text(
                              bonus.toStringAsFixed(3),
                              style: kWhiteText,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CardContainer(
              color: Colors.lightGreen[400],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue[700],
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: shop,
                                    child: Container(
                                      color: Colors.blue[900],
                                      child: Center(
                                        child: Text(
                                          'М',
                                          style: kShopWhiteText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: cases,
                                    child: Container(
                                      color: Colors.blue[900],
                                      child: Center(
                                        child: Text(
                                          'К',
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
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            addShopItem(
                                'Молоток', 'Лучше чем ничего', 0.010, 0.001, 0),
                            addShopItem(
                                'Лопата',
                                'Копать удобно но трудно разбивать камни',
                                0.100,
                                0.010,
                                1),
                            addShopItem(
                                'Кирка',
                                'Идеально подходит для добычи руды',
                                1.000,
                                0.100,
                                2),
                            addShopItem(
                                'Бур-Машина',
                                'Самая большая скорость добычи',
                                100.000,
                                1.000,
                                3),
                            addShopItem(
                                'Динамит',
                                'Взрыв огромного пространства',
                                1000.000,
                                10.000,
                                4),
                            addShopItem('Копатели', 'Теперь работать будут они',
                                10000.000, 100.000, 5),
                            addShopItem('Подрыватели', 'Взрывают всё что видят',
                                100000.000, 1000.000, 6)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CaseItem(
                              cost: 100,
                              bonus: bonus,
                              color: Color(0xffcd8760),
                              title: 'Бронзовый кейс',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: 10,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 500,
                                ),
                                CaseWin(
                                  color: Colors.grey,
                                  win: 30,
                                ),
                                CaseWin(
                                  color: Colors.grey,
                                  win: 1,
                                ),
                                CaseWin(
                                  color: Colors.black87,
                                  win: -100,
                                ),
                                CaseWin(
                                  color: Colors.grey,
                                  win: 50,
                                ),
                              ],
                            ),
                            CaseItem(
                              cost: 500,
                              bonus: bonus,
                              color: Color(0xff828282),
                              title: 'Серебряный кейс',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: 100,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 1000,
                                ),
                                CaseWin(
                                  color: Colors.blue,
                                  win: 200,
                                ),
                                CaseWin(
                                  color: Colors.purpleAccent,
                                  win: 300,
                                ),
                                CaseWin(
                                  color: Colors.black87,
                                  win: -100,
                                ),
                              ],
                            ),
                            CaseItem(
                              cost: 1000,
                              bonus: bonus,
                              color: Color(0xffe0ac00),
                              title: 'Золотой кейс',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: 100,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 10000,
                                ),
                                CaseWin(
                                  color: Colors.blue,
                                  win: 300,
                                ),
                                CaseWin(
                                  color: Colors.purpleAccent,
                                  win: 600,
                                ),
                                CaseWin(
                                  color: Colors.black87,
                                  win: -100,
                                ),
                              ],
                            ),
                            CaseItem(
                              cost: 10000,
                              bonus: bonus,
                              color: Color(0xff00d9e0),
                              title: 'Алмазный кейс',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: 1000,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 100000,
                                ),
                                CaseWin(
                                  color: Colors.blue,
                                  win: 5000,
                                ),
                                CaseWin(
                                  color: Colors.purpleAccent,
                                  win: 12000,
                                ),
                                CaseWin(
                                  color: Colors.black87,
                                  win: -100,
                                ),
                              ],
                            ),
                            CaseItem(
                              cost: 100000,
                              bonus: bonus,
                              color: Color(0xffe04700),
                              title: 'Кейс 50 / 50',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: 0,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 200000,
                                ),
                                CaseWin(
                                  color: Colors.grey,
                                  win: 0,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 200000,
                                ),
                              ],
                            ),
                            CaseItem(
                              cost: 1000000,
                              bonus: bonus,
                              color: Color(0xffff6c6c),
                              title: 'Мега кейс',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: 500000,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: 10000000,
                                ),
                                CaseWin(
                                  color: Colors.blue,
                                  win: 500000,
                                ),
                                CaseWin(
                                  color: Colors.purpleAccent,
                                  win: 1200000,
                                ),
                                CaseWin(
                                  color: Colors.black87,
                                  win: -10000,
                                ),
                              ],
                            ),
                            CaseItem(
                              cost: clicks,
                              bonus: bonus,
                              color: Color(0xff00c722),
                              title: 'На все деньги',
                              onPress: toScreen,
                              balance: clicks,
                              items: [
                                CaseWin(
                                  color: Colors.grey,
                                  win: clicks / 2,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: clicks * 3,
                                ),
                                CaseWin(
                                  color: Colors.grey,
                                  win: clicks / 2,
                                ),
                                CaseWin(
                                  color: Colors.red,
                                  win: clicks * 3,
                                ),
                              ],
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                title: Text('Coin crash'),
                                trailing: GestureDetector(
                                  onTap: goToCoinCrash,
                                  child: Icon(
                                    Icons.open_in_new,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ][shopItem],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
