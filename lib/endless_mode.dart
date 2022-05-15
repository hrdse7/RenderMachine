import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'play_model.dart';

class EndlessModePage extends StatefulWidget {
  String name;
  int endlessScoredata;

  EndlessModePage({required this.name, required this.endlessScoredata});

  @override
  EndlessModePageState createState() =>
      EndlessModePageState(name: name, endlessScoredata: endlessScoredata);
}

class EndlessModePageState extends State<EndlessModePage> {
  String name;
  int endlessScoredata;

  EndlessModePageState({required this.name, required this.endlessScoredata});

  //ボタンタップ回数を示すインスタンス変数
  int _counter = 0;
  var countData;

  //ボタンを押すとカウントされる
  void _incrementCounter() {
    setState(() {
      countData = endlessScoredata + _counter++;
    });
  }

  //shared_preferences
  // データのスコアと現在のスコアを比較し最大スコアをデータの書き込み保存
  _setPrefItems(userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('endless-$userName', countData);
  }

  //ページが変わったらデータのカウント表示させる
  @override
  void initState() {
    _incrementCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<TenStopWatchModel>(
      create: (_) => TenStopWatchModel(),
      child: Consumer<TenStopWatchModel>(builder: (context, model, child) {
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/background.jpeg'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // これで両端に寄せる

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 110, left: 20),
                      child: Container(
                        child: const Text(
                          'NO LIMIT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100, right: 20),
                      child: OutlinedButton(
                        onPressed: () {
                          _setPrefItems(name);

                          Navigator.pop(context, _counter);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(160, 60),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 251, 255, 0), //枠線の色
                            width: 2,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'QUIT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$countData',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Color.fromARGB(255, 0, 238, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        Visibility(
                          visible: model.isHide,
                          child: ElevatedButton(
                            //10秒になったらnullでボタンが非活性
                            onPressed: () {
                              _incrementCounter();
                            },
                            style: ElevatedButton.styleFrom(
                              //ボタン透明
                              primary: Colors.transparent,
                              //影
                              elevation: 3,
                              //枠線
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 221),
                              ),
                              // primary: Colors.pink,
                              minimumSize: const Size(90, 120),
                            ),
                            child: const Text(''),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        Visibility(
                          visible: model.isHide,
                          child: ElevatedButton(
                            //10秒になったらnullでボタンが非活性
                            onPressed: () {
                              _incrementCounter();
                            },
                            style: ElevatedButton.styleFrom(
                              //ボタン透明
                              primary: Colors.transparent,
                              //影
                              elevation: 3,
                              //枠線
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 221),
                              ),
                              // primary: Colors.pink,
                              minimumSize: const Size(90, 120),
                            ),
                            child: const Text(''),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        Visibility(
                          visible: model.isHide,
                          child: ElevatedButton(
                            //10秒になったらnullでボタンが非活性
                            onPressed: () {
                              _incrementCounter();
                            },
                            style: ElevatedButton.styleFrom(
                              //ボタン透明
                              primary: Colors.transparent,
                              //影
                              elevation: 3,
                              //枠線
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 221),
                              ),
                              // primary: Colors.pink,
                              minimumSize: const Size(90, 120),
                            ),
                            child: const Text(''),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        Visibility(
                          visible: model.isHide,
                          child: ElevatedButton(
                            //10秒になったらnullでボタンが非活性
                            onPressed: () {
                              _incrementCounter();
                            },
                            style: ElevatedButton.styleFrom(
                              //ボタン透明
                              primary: Colors.transparent,
                              //影
                              elevation: 3,
                              //枠線
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 221),
                              ),
                              // primary: Colors.pink,
                              minimumSize: const Size(90, 120),
                            ),
                            child: const Text(''),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    ));
  }
}
