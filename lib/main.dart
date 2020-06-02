import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Detail',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
      ),
      home: RepoDetailPage('GitHub Repo Detail'),
    );
  }
}

class RepoDetailPage extends StatefulWidget {
  final String title;

  RepoDetailPage(this.title);
  @override
  _RepoDetailPageState createState() => _RepoDetailPageState(this.title);
}

class _RepoDetailPageState extends State<RepoDetailPage> {
  final String title;
  int forks = 0;
  int stargazers = 0;
  String languages = "";

  Map<String, dynamic> repoDetail;

//  static const platform = const MethodChannel('repoInfo/details');
  // TODO: Find the right channel
  static const repoDetailMethodChannel = const MethodChannel('repoInfo/details');
  static const repoListMethodChannel = const MethodChannel('repoInfo/list');

  _RepoDetailPageState(this.title);

//  {
//    platform.setMethodCallHandler(_handleMethod);
//  }

  @override
  void initState() {
    print("In initState");
//    forks = 1;
//    stargazers = 1;
    repoDetailMethodChannel.setMethodCallHandler(_handleMethod);
    super.initState();
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
//    print('The data looks like ${call.arguments}');
//    Map valueMap = jsonDecode(call.arguments);
//    print('Decoded data is $valueMap');

    switch (call.method) {
      case "dataToDetailFlutterComponent":
        {
          print('Received data looks like ${call.arguments}');
          Map valueMap = jsonDecode(call.arguments);
          print('Decoded data is $valueMap');

          repoDetail = valueMap['repoDetail'];
          print('repoDetail data is $repoDetail');

//          forks = repoDetail['forks'];
//          stargazers = repoDetail['stargazers'];
//          languages = repoDetail['languages'].toString();
//
//          print('forks ${repoDetail['forks']}');
//          print('stargazers ${repoDetail['stargazers']}');
//          print('languages ${repoDetail['languages']}');
//          forks = repoDetail['forks'];
//          stargazers = repoDetail['stargazers'];
//          languages = repoDetail['languages'].toString();

          setState(() {
            print('start of setState');
            forks = repoDetail['forks'];
            stargazers = repoDetail['stargazers'];
            languages = repoDetail['languages'].toString();

            print('in setState fork is ${forks}');
            print('in setState stargazers is ${stargazers}');
            print('in setState languages is ${languages}');

          });
        }

    }
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Card(
        //color: Colors.grey,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 80.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                child: Image.network(
                    'https://avatars2.githubusercontent.com/u/6253321?s=460&v=4'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text("Title",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Text("Stargazers"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(stargazers.toString()),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Text("Forks"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(forks.toString()),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Text("Language"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(languages),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Description.*.",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            ButtonBarTheme(
              data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
              child: ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Details",
                      style: TextStyle(
                          //color: Theme.of(context).accentColor
                          ),
                    ),
                    onPressed: () => _handleBack(),
                  ),
                  RaisedButton(
                    child: Text("Back"),
                    onPressed: () => _passMessageBack(context),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // TODO: Fix the handleback with another method to invoke a method
  _handleBack() {
    final jsonString = """
  {
  "repoDetail": {
    "stargazers": 6,
    "forks": 6,
    "languages": [
      "kotlin",
      "java"
    ]    
  }
}
""";

    Map valueMap = jsonDecode(jsonString);
    print(valueMap);
    Map repoDetail = valueMap['repoDetail'];
    final forks = repoDetail['forks'];
    final stargazers = repoDetail['stargazers'];
    final languages = repoDetail['languages'];
    print(languages);
    final methodCall = MethodCall("message", jsonString);
    _handleMethod(methodCall);
  }

  _passMessageBack(BuildContext context) async {
    await repoListMethodChannel.invokeMethod("handleMessageBack", "Hi from Flutter");
  }
}
