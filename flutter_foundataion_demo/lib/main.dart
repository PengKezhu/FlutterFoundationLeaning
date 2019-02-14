import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // debugPaintPointersEnabled = true;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyScafford(),
    );
  }
}

class MyScafford extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Container(
              color: Colors.yellow,
                child: new Text('MyAppBar',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white))),
          ),
          new Expanded(
            child: new Center(
              child: new Text('Hello World!'),
            ),
          )
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 88.0,
        decoration: new BoxDecoration(color: Colors.blue[500]),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new SizedBox(
              height: 44.0,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.menu, color: Colors.white),
                      onPressed: null),
                  new Expanded(
                    child: title,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.search, color: Colors.white),
                    onPressed: null,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
