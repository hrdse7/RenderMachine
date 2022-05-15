import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'play_model.dart';

class TenModePage extends StatefulWidget {
  // //MainPageからdataのスコアと入力値を受け取る名前を代入する変数を定義
  String name;
  int tenScoredata;
  //受け取る値を上記の変数に代入
  TenModePage({required this.name, required this.tenScoredata});

  @override
  TenModePageState createState() =>
      TenModePageState(name: name, tenScoredata: tenScoredata);
}

class TenModePageState extends State<TenModePage> {
  //TenModePageから受け取る名前を代入する変数を定義
  String name;
  int tenScoredata;
  // //受け取る値を上記の変数に代入
  TenModePageState({required this.name, required this.tenScoredata});

  //ボタンタップ回数を示すインスタンス変数
  var _counter = -1;

  //テキスト表示
  bool isShowText = true;
  //カウント表示
  bool isShowCount = false;

  String showText = 'Press any\nbutton to start';

  //tenStopWatchModelをインスタンス化
  TenStopWatchModel tenStopWatchModel = TenStopWatchModel();

  //ボタンを押すとカウントされる
  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  //shared_preferences
  // データのスコアと現在のスコアを比較し最大スコアをデータの書き込み保存
  _setPrefItems(userName) async {
    final prefs = await SharedPreferences.getInstance();
    if (_counter > tenScoredata) {
      await prefs.setInt('10-$userName', _counter);
    }
  }

  //disposeメソッド（インスタンスを捨てる）
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tenStopWatchModel.stopStopWatch();
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // これで両端に寄せる

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 110, left: 20),
                      child: Container(
                        child: Text(
                          model.tenStopWatchTimeDisplay,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100, right: 20),
                      child: OutlinedButton(
                        onPressed: () {
                          if (model.tenStopWatchTimeDisplay == '10:00') {
                            _setPrefItems(name);
                          } else {
                            model.stopStopWatch();
                          }

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
              Visibility(
                visible: isShowText,
                child: SizedBox(
                  height: 80,
                  child: Text(
                    showText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 0, 238, 255),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isShowCount,
                child: SizedBox(
                  height: 80,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '$_counter',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 60,
                        color: Color.fromARGB(255, 0, 238, 255),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Visibility(
                    visible: model.isShow,
                    child: Container(
                      //中央揃え
                      alignment: Alignment.center,
                      height: 440.0,
                      width: 330.0,
                      // color: Colors.yellow,
                      child: const Text(
                        "Time's Up!!!",
                        style: TextStyle(
                            fontSize: 50,
                            color: Color.fromARGB(255, 251, 255, 0)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        Visibility(
                          visible: model.isHide,
                          child: ElevatedButton(
                            //10秒になったらnullでボタンが非活性
                            onPressed: model.tenSwatch.elapsed.inSeconds == 10
                                ? null
                                : () {
                                    isShowCount = true;
                                    isShowText = false;
                                    model.startStopWatch();
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
                            child: Text(''),
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
                            onPressed: model.tenSwatch.elapsed.inSeconds == 10
                                ? null
                                : () {
                                    isShowCount = true;
                                    isShowText = false;
                                    model.startStopWatch();
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
                            onPressed: model.tenSwatch.elapsed.inSeconds == 10
                                ? null
                                : () {
                                    isShowCount = true;
                                    isShowText = false;
                                    model.startStopWatch();
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
                            onPressed: model.tenSwatch.elapsed.inSeconds == 10
                                ? null
                                : () {
                                    isShowCount = true;
                                    isShowText = false;
                                    model.startStopWatch();
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
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
