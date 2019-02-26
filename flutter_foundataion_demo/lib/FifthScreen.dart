import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/Cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:isolate';
import 'dart:convert';
import 'SixthScreen.dart';

class FifthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FifthScreenState();
  }
}

class FifthScreenState extends State {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;
    List responseWidgets = await sendReceive(
        sendPort, 'https://jsonplaceholder.typicode.com/posts');
    setState(() {
      widgets = responseWidgets;
    });
    // print('count: $widgets.count');
  }

  Future sendReceive(SendPort sendPort, msg) {
    ReceivePort response = ReceivePort();
    sendPort.send([msg, response.sendPort]);
    return response.first;
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for (var msg in receivePort) {
      print('var msg in receivePort');
      String data = msg[0];
      SendPort replyTo = msg[1];
      String dataURL = data;
      http.Response response = await http.get(dataURL);
      replyTo.send(json.decode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Five',
      theme: ThemeData(primarySwatch: Colors.green, primaryColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(
            title: GestureDetector(
          child: const Text('Isolate'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SixthScreen()));
          },
        )),
        body: Container(
          child: Center(
            child: widgets.length > 0
                ? ListView(
                    children: widgets
                        .map((post) => Text(post['title'] + '\n'))
                        .toList(),
                  )
                : CircularProgressIndicator(backgroundColor: Colors.black),
          ),
        ),
      ),
    );
  }
}
