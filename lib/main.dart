import 'package:flutter/material.dart';

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
      home: MyHomePage('GitHub Repo Detail'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage(this.title);

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
                  Text("Staggers"),
                  SizedBox(
                    width: 20,
                  ),
                  Text("2"),
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
                  Text("2"),
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
                  Text("Kotlin"),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Description..................",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Details",
                      style: TextStyle(
                          //color: Theme.of(context).accentColor
                          ),
                    ),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("Back"),
                    onPressed: () {},
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
