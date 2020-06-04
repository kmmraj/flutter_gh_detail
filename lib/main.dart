import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//void main() => runApp(MyApp());
/// The entrypoint for the flutter module.
void main() {
  // This call ensures the Flutter binding has been set up before creating the
  // MethodChannel-based model.
  WidgetsFlutterBinding.ensureInitialized();

  final model = RepoDetailModel();

  runApp(
    ChangeNotifierProvider.value(
      value: model,
      child: MyApp(),
    ),
  );
}

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

class RepoDetailModel extends ChangeNotifier {
  int _forks = 1;
  int _stargazers = 1;
  String _languages = "";
  bool favorite = false;

  int get forks => _forks;
  int get stargazers => _stargazers;
  String get languages => _languages;

  RepoDetailModel() {
    _repoDetailMethodChannel.setMethodCallHandler(_handleMethod);
  }

  final _repoDetailMethodChannel = const MethodChannel('repoInfo/details');

  //final _repoListMethodChannel = const MethodChannel('repoInfo/list');

// TODO : Fix the back channel - 1
  passMessageBack(bool isFavorite) async {
    await _repoDetailMethodChannel.invokeMethod(
        "handleMessageBack", isFavorite);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "dataToDetailFlutterComponent":
        {
          print('Received data looks like ${call.arguments}');
          Map valueMap = jsonDecode(call.arguments);
          print('Decoded data is $valueMap');

          final Map<String, dynamic> repoDetail = valueMap['repoDetail'];
          print('repoDetail data is $repoDetail');
          _forks = repoDetail['forks'];
          _stargazers = repoDetail['stargazers'];
          _languages = repoDetail['languages'].toString();
          this.notifyListeners();

          print('in _handleMethod fork is $forks');
          print('in _handleMethod stargazers is $stargazers');
          print('in _handleMethod languages is $languages');
          return true;
        }
    }
  }
}

class RepoDetailPage extends StatelessWidget {
  final String title;

  const RepoDetailPage(this.title);
//
//  RepoDetailPage(this.title);
//  @override
//  _RepoDetailPageState createState() => _RepoDetailPageState(this.title);
//}
//
//class _RepoDetailPageState extends State<RepoDetailPage> {
//  final String title;
//  int forks = 0;
//  int stargazers = 0;
//  String languages = "";
//
//  Map<String, dynamic> repoDetail;
//
////  static const platform = const MethodChannel('repoInfo/details');
//  // TODO: Find the right channel
//  static const repoDetailMethodChannel =
//      const MethodChannel('repoInfo/details');
//  static const repoListMethodChannel = const MethodChannel('repoInfo/list');
//
//  _RepoDetailPageState(this.title);
//
////  {
////    platform.setMethodCallHandler(_handleMethod);
////  }
//
//  @override
//  void initState() {
//    print("In initState");
////    forks = 1;
////    stargazers = 1;
//    repoDetailMethodChannel.setMethodCallHandler(_handleMethod);
//    super.initState();
//  }
//
//  Future<dynamic> _handleMethod(MethodCall call) async {
////    print('The data looks like ${call.arguments}');
////    Map valueMap = jsonDecode(call.arguments);
////    print('Decoded data is $valueMap');
//
//    switch (call.method) {
//      case "dataToDetailFlutterComponent":
//        {
//          print('Received data looks like ${call.arguments}');
//          Map valueMap = jsonDecode(call.arguments);
//          print('Decoded data is $valueMap');
//
//          repoDetail = valueMap['repoDetail'];
//          print('repoDetail data is $repoDetail');
//
////          forks = repoDetail['forks'];
////          stargazers = repoDetail['stargazers'];
////          languages = repoDetail['languages'].toString();
////
////          print('forks ${repoDetail['forks']}');
////          print('stargazers ${repoDetail['stargazers']}');
////          print('languages ${repoDetail['languages']}');
////          forks = repoDetail['forks'];
////          stargazers = repoDetail['stargazers'];
////          languages = repoDetail['languages'].toString();
//
//          setState(() {
//            print('start of setState');
//            forks = repoDetail['forks'];
//            stargazers = repoDetail['stargazers'];
//            languages = repoDetail['languages'].toString();
//
//            print('in setState fork is ${forks}');
//            print('in setState stargazers is ${stargazers}');
//            print('in setState languages is ${languages}');
//          });
//        }
//    }
//    return new Future.value(true);
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: Remove Consumer at Top of tree
    return Consumer<RepoDetailModel>(
      builder: (context, model, widget) {
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
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text("Title",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40)),
                    ),
                    IconButton(
                      icon: Icon(
                        model.favorite ? Icons.star : Icons.star_border,
                        color: model.favorite ? Colors.red : Colors.grey,
                        size: 40,
                      ),
                      onPressed: () {
                        model.favorite = !model.favorite;
                        model.notifyListeners();
                       // model.passMessageBack(model.favorite);
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text("Stargazers"),
                      SizedBox(
                        width: 20,
                      ),
                      Consumer<RepoDetailModel>(
                          builder: (context, model, widget) {
                        print('in widget stargazers is ${model.stargazers}');
                        return Text('${model.stargazers}');
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<RepoDetailModel>(builder: (context, model, widget) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text("Forks"),
                        SizedBox(
                          width: 20,
                        ),
                        Text(model.forks.toString()),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Consumer<RepoDetailModel>(builder: (context, model, widget) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text("Language"),
                        SizedBox(
                          width: 20,
                        ),
                        Text(model.languages),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    "Description.....",
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
                        onPressed: () => _handleDetails(model),
                      ),
                      RaisedButton(
                        child: Text("Back"),
                        onPressed: () =>  model.passMessageBack(model.favorite),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _handleDetails(RepoDetailModel model) {
    print('In _handleDetails');
    // TODO launch a new screen - webview
  }

  // TODO: Fix the handleback with another method to invoke a method
//  _handleBack() {
//    final jsonString = """
//  {
//  "repoDetail": {
//    "stargazers": 6,
//    "forks": 6,
//    "languages": [
//      "kotlin",
//      "java"
//    ]
//  }
//}
//""";
//
//    Map valueMap = jsonDecode(jsonString);
//    print(valueMap);
//    Map repoDetail = valueMap['repoDetail'];
//    final forks = repoDetail['forks'];
//    final stargazers = repoDetail['stargazers'];
//    final languages = repoDetail['languages'];
//    print(languages);
//    final methodCall = MethodCall("message", jsonString);
//    _handleMethod(methodCall);
//  }
//

}
