import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Detail',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.orange
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
      body:
        Card(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(),
                title: Text("GH repo 1..."),
                onTap: () {},
                subtitle: Text("Details"),
              ),



              ButtonTheme.bar(
                child: ButtonBar(children: <Widget>[
                  RaisedButton(child: Text("Details", style: TextStyle(
                    color: Theme.of(context).accentColor
                  ),),onPressed: (){},),
                  FlatButton(child: Text("Back"), onPressed: (){},)
                ],),
              )
            ],
          ),
        ),

    );
  }
}
