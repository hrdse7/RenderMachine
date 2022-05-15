import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'endless_mode.dart';
import 'mode.dart';
import 'sixty_mode.dart';
import 'ten_mode.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //googleFont
        theme: ThemeData(
          textTheme: GoogleFonts.orbitronTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        //Slow Mode"バナーを非表示
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //キーボード表示の時エラーを出さない
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/background.jpeg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //渡したい変数(scorenum)を引数に指定する
                MainPage(),
              ],
            ),
          ),
        ));
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  //
  final _controller = TextEditingController();

  //TextFieldの値を代入する変数を定義
  String inputName = '';

  //データの入る変数を定義
  int tenScoredata = 0;
  int sixtyScoredata = 0;
  int endlessScoredata = 0;

  //モード選択のgroupValueの変数定義
  int _value = 1;

  //書き込まれているデータのスコアを表示する変数定義
  String tenViewScore = '---';
  String sixtyViewScore = '---';
  String endlessViewScore = '---';

  //表示/非表示
  bool isShow = false;
  bool isHide = false;

  //
  // var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();

    _controller.text = prefs.getString('currentUser')!;
    _value = prefs.getInt('mode')!;

    //currentUserを_getPrefItemsのkyeの名前に格納
    inputName = _controller.text;
    //inputNameに_getDataに保存されている名前入れる
    _getPrefItems(inputName);

    if (_controller.text != null) {
      isShow = true;
    }
  }

  //保存
  Future<void> _setData(inputName) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('currentUser', inputName);
    prefs.setInt('mode', _value);
  }

  //保存されているデータを読み込んで、にセットする
  _getPrefItems(userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 以下の「inputname」がキー名。見つからなければ空文字を返す
    setState(() {
      tenScoredata = prefs.getInt('10-$userName') ?? 0;
      sixtyScoredata = prefs.getInt('60-$userName') ?? 0;
      endlessScoredata = prefs.getInt('endless-$userName') ?? 0;
    });

    print(tenScoredata);
    print(sixtyScoredata);
    print(endlessScoredata);

    this.tenViewScore = '$tenScoredata';
    this.sixtyViewScore = '$sixtyScoredata';
    this.endlessViewScore = '$endlessScoredata';

    if (inputName.length == 0) {
      isShow = false;
      isHide = true;
      this.tenViewScore = '---';
      this.sixtyViewScore = '---';
      this.endlessViewScore = '---';
    }
  }

  // // Shared Preferenceのデータを削除する
  // _removePrefItems(userName) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  const Text('10s',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 251, 255, 0))),
                  // Text((scoredata >= 0) ? '${scoredata}' : '---',
                  Text('${this.tenViewScore}',
                      style:
                          const TextStyle(fontSize: 25, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Text('60s',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 251, 255, 0))),
                  Text('${this.sixtyViewScore}',
                      style:
                          const TextStyle(fontSize: 25, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Text('ENDLESS',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 251, 255, 0))),
                  Text('${this.endlessViewScore}',
                      style:
                          const TextStyle(fontSize: 25, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: const Text(
          'Renda\nMachine',
          style: TextStyle(fontSize: 60, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        width: 280,
        height: 50,
        child: TextFormField(
            //テキスト中央揃え
            textAlign: TextAlign.center,
            //テキストのサイズ
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              //初期値の文字
              hintText: "Enter Nickname...",
              //TextFormFieldの枠線を削除
              border: InputBorder.none,
              //「fillColor引数」で背景色
              fillColor: Colors.white,
              //「filled引数」に「true」
              filled: true,
            ),

            //
            controller: _controller,

            //入力された値時データを取得
            onChanged: (text) {
              inputName = text;
              if (inputName.length >= 0) {
                isShow = true;
                isHide = false;
                //
                _setData(inputName);
                //データ取得
                _getPrefItems(inputName);
              }
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Visibility(
            visible: isShow,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 28, left: 20),
              child: ModeRadioList<int>(
                  value: 1,
                  groupValue: _value,
                  leading: '10s',
                  onChanged: (value) => setState(() {
                        _value = value!;
                        _setData(inputName);
                      })),
            ),
          ),
          Visibility(
            visible: isShow,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 28, left: 5, right: 5),
              child: ModeRadioList<int>(
                  value: 2,
                  groupValue: _value,
                  leading: '60s',
                  onChanged: (value) => setState(() {
                        _value = value!;
                        _setData(inputName);
                      })),
            ),
          ),
          Visibility(
            visible: isShow,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 28, right: 20),
              child: ModeRadioList<int>(
                  value: 3,
                  groupValue: _value,
                  leading: 'ENDLESS',
                  onChanged: (value) => setState(() {
                        _value = value!;
                        _setData(inputName);
                      })),
            ),
          ),
        ],
      ),
      Visibility(
        visible: isShow,
        child: Container(
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 80),
          child: OutlinedButton(
            onPressed: () {
              // //Playボタンを押すタイミングでdataを書き込む
              // _setPrefItems();
              if (_value == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        //表示するページ(ウィジェット)を指定する
                        builder: (context) => TenModePage(
                            name: inputName,
                            tenScoredata: tenScoredata))).then((value) {
                  //画面が戻ってきたら最大スコアを表示
                  _getPrefItems(inputName);
                });
              } else if (_value == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        //表示するページ(ウィジェット)を指定する
                        builder: (context) => SixtyModePage(
                            name: inputName,
                            sixtyScoredata: sixtyScoredata))).then((value) {
                  //画面が戻ってきたら最大スコアを表示
                  _getPrefItems(inputName);
                });
              } else if (_value == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        //表示するページ(ウィジェット)を指定する
                        builder: (context) => EndlessModePage(
                            name: inputName,
                            endlessScoredata: endlessScoredata))).then((value) {
                  //画面が戻ってきたら最大スコアを表示
                  _getPrefItems(inputName);
                });
              }
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(350, 70),
              side: const BorderSide(
                color: Color.fromARGB(255, 255, 0, 221), //枠線の色
                width: 2,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'PLAY!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 33,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
